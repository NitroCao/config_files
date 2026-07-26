local M = {}

local defaults = {
    keymap = '<Leader>jp',
    max_depth = 8,
    window = {
        border = 'rounded',
        height = 0.8,
        width = 0.8,
    },
}

local value_node_types = {
    array = true,
    ['false'] = true,
    null = true,
    number = true,
    object = true,
    string = true,
    ['true'] = true,
}

local function notify(message, level)
    vim.notify(message, level, { title = 'JSON' })
end

local function get_value_node(bufnr)
    local filetype = vim.bo[bufnr].filetype
    local language = vim.treesitter.language.get_lang(filetype) or filetype
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, language)

    if not ok then
        return nil, ('Tree-sitter parser not available for %s'):format(filetype)
    end

    parser:parse()

    local node = vim.treesitter.get_node({ bufnr = bufnr })
    if not node then
        return nil, 'No JSON value under cursor'
    end

    local current = node
    while current do
        if current:type() == 'pair' then
            return current:field('value')[1]
        end
        current = current:parent()
    end

    current = node
    while current and not value_node_types[current:type()] do
        current = current:parent()
    end

    if not current then
        return nil, 'No JSON value under cursor'
    end

    return current
end

local function decode_value(raw, max_depth)
    local ok, value = pcall(vim.json.decode, raw, { skip_comments = true })
    if not ok then
        return nil, value
    end

    for _ = 1, max_depth do
        if type(value) ~= 'string' then
            break
        end

        local text = vim.trim(value)
        local first = text:sub(1, 1)
        if first ~= '{' and first ~= '[' and first ~= '"' then
            break
        end

        local decoded, nested = pcall(vim.json.decode, text, { skip_comments = true })
        if not decoded then
            break
        end
        value = nested
    end

    return value
end

local function display_value(value)
    if type(value) == 'string' then
        return value, 'markdown'
    end

    return vim.json.encode(value, {
        indent = '  ',
        sort_keys = true,
    }), 'json'
end

local function close_window(winid)
    if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_close(winid, true)
    end
end

local function open_preview(text, filetype, options)
    local lines = vim.split(text, '\n', { plain = true })
    local max_width = math.max(1, vim.o.columns - 4)
    local max_height = math.max(1, vim.o.lines - 4)
    local width = math.min(math.max(1, math.floor(vim.o.columns * options.width)), max_width)
    local content_height = 0
    for _, line in ipairs(lines) do
        content_height = content_height + math.max(1, math.ceil(vim.fn.strdisplaywidth(line) / width))
    end
    local height = math.min(
        math.max(1, content_height),
        math.min(math.max(1, math.floor(vim.o.lines * options.height)), max_height)
    )

    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.bo[bufnr].bufhidden = 'wipe'
    vim.bo[bufnr].filetype = filetype
    vim.bo[bufnr].modifiable = false

    local winid = vim.api.nvim_open_win(bufnr, true, {
        border = options.border,
        col = math.max(0, math.floor((vim.o.columns - width) / 2)),
        height = height,
        relative = 'editor',
        row = math.max(0, math.floor((vim.o.lines - height) / 2) - 1),
        style = 'minimal',
        title = (' decoded %s '):format(filetype),
        title_pos = 'center',
        width = width,
    })

    vim.wo[winid].conceallevel = filetype == 'markdown' and 2 or 0
    vim.wo[winid].linebreak = true
    vim.wo[winid].wrap = true

    pcall(vim.treesitter.start, bufnr, filetype)

    if filetype == 'markdown' then
        local ok, renderer = pcall(require, 'render-markdown')
        if ok then
            renderer.set_buf(true)
        end
    end

    local close = function()
        close_window(winid)
    end
    local keymap_options = { buffer = bufnr, nowait = true, silent = true }
    vim.keymap.set('n', '<Esc>', close, keymap_options)
    vim.keymap.set('n', 'q', close, keymap_options)
end

function M.peek(options)
    options = vim.tbl_deep_extend('force', defaults, options or {})

    local bufnr = vim.api.nvim_get_current_buf()
    local node, node_error = get_value_node(bufnr)
    if not node then
        notify(node_error, vim.log.levels.WARN)
        return
    end

    local raw = vim.treesitter.get_node_text(node, bufnr)
    local value, decode_error = decode_value(raw, options.max_depth)
    if value == nil then
        notify(('Unable to decode JSON value: %s'):format(decode_error), vim.log.levels.ERROR)
        return
    end

    local text, filetype = display_value(value)
    open_preview(text, filetype, options.window)
end

local function configure_buffer(args, options)
    local bufnr = args.buf

    vim.bo[bufnr].shiftwidth = 2
    vim.bo[bufnr].softtabstop = 2
    vim.bo[bufnr].tabstop = 2

    vim.api.nvim_buf_create_user_command(bufnr, 'JsonPeek', function()
        M.peek(options)
    end, {
        desc = 'Decode and preview the JSON value under the cursor',
        force = true,
    })

    vim.keymap.set('n', options.keymap, function()
        M.peek(options)
    end, {
        buffer = bufnr,
        desc = 'Decode and preview JSON value',
        silent = true,
    })
end

function M.setup(options)
    options = vim.tbl_deep_extend('force', defaults, options or {})

    local group = vim.api.nvim_create_augroup('JsonConfig', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = { 'json', 'json5', 'jsonc' },
        callback = function(args)
            configure_buffer(args, options)
        end,
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        pattern = { '*.json', '*.json5', '*.jsonc' },
        callback = function()
            if vim.fn.exists('*CocActionAsync') == 1 then
                vim.fn.CocActionAsync('format')
            end
        end,
    })
end

return M

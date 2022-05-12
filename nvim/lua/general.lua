vim.g.mapleader = ' '
vim.o.relativenumber = true
vim.o.number = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.laststatus = 2
vim.o.fileformats = 'unix,dos'
vim.o.sessionoptions = 'blank,buffers,curdir,globals,folds,tabpages,localoptions,options,resize,winpos,winsize'
vim.o.undodir = vim.env.HOME .. "/.vim/.undo_history"
vim.o.undofile = true
vim.o.showmode = false
vim.o.wrap = true
vim.o.updatetime = 100
vim.o.signcolumn = 'yes'
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'
vim.cmd('hi clear signcolumn')
vim.cmd('colorscheme dracula')
vim.o.cursorcolumn = true
vim.o.termguicolors = true
vim.wo.cursorline = true
vim.cmd([[
    hi clear CursorLine
    hi clear SignColumn
    hi CursorLineNr guifg=Red
]])

if os.getenv('HOMEBREW_PREFIX') == '' then
    vim.g.python3_host_prog = '/usr/bin/python3'
else
    vim.g.python3_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/python3'
end

vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ww', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>x', ':x<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>bd', ':bd<CR>', { noremap = true, silent = true })


-- options for Leaderf plugin
vim.api.nvim_set_var('Lf_WindowPosition', 'popup')
-- vim.api.nvim_set_var('Lf_PreviewInPopup', 1)
vim.api.nvim_set_var('Lf_ShortcutF', '<leader>lf')
vim.api.nvim_set_var('Lf_ShortcutB', '<leader>lb')
vim.api.nvim_set_var('Lf_DefaultMode', 'FullPath')
vim.g['Lf_WildIgnore'] = {
    dir = {'.svn', '.git', '.hg', 'tmp', '.build'},
    file = {'*.o', '*.so', '*.py[co]'}
}
vim.g['Lf_GtagsAutoGenerate'] = 0
vim.g['Lf_Gtagslabel'] = 'native-pygments'
vim.g['Lf_CursorBlink'] = 1
-- vim.g['Lf_PreviewCode'] = 1

vim.api.nvim_set_keymap('n', '<Leader>lF', ':LeaderfFunction<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ls', ':<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltt', ':<C-U><C-R>=printf("Leaderf tag --input %s", expand("<cword>"))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltr', ':<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltd', ':<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltn', ':<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltn', ':<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leaderf>lm', '<C-U><C-R>=printf("Leaderf mru %s", expand("<cword>"))<CR>', { noremap = true, silent = true })


-- options for coc.nvim
function _G.check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end
function _G.show_documentation()
    if vim.fn['coc#rpc#ready']() == 1 then
        vim.fn['CocActionAsync']('doHover')
    elseif { 'vim', 'help' } ~= vim.o.filetype then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    end
end

vim.g['coc_global_extensios'] = {
    'coc-json',
    'coc-yaml',
    'coc-snippets',
    'coc-pairs',
    'coc-go',
    'coc-clangd',
    'coc-pyright'
}

vim.api.nvim_set_keymap('n', 'K', [[ <Cmd>lua show_documentation()<CR> ]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : v:lua.check_back_space() ? "<Tab>" : coc#refresh()', { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', 'complete_info()["selected"] != "-1" ? "<C-y>" : "<C-g>u<CR>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('n', 'g[', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.api.nvim_set_keymap('n', 'g]', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', 'gt', '<Plug>(coc-type-definition)', {})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', 'gn', '<Plug>(coc-rename)', {})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})


vim.cmd([[
augroup group1
    autocmd!

    autocmd FileType yaml,json setlocal shiftwidth=2 softtabstop=2 tabstop=2
    autocmd BufWritePre *.py,*.go,*.json,*.yml,*.yaml :silent! call CocAction('format')
    autocmd BufWritePre *.go,*.py :silent! call CocAction('runCommand', 'editor.action.organizeImport')
    autocmd BufWritePre *.py :silent! call CocAction('runCommand', 'python.sortImports')
augroup END
]])


require('plugin.lualine')
require('bufferline').setup{}
require('Comment').setup{}
require('nvim-treesitter.configs').setup{
    ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'dockerfile',
        'go',
        'gomod',
        'json',
        'json5',
        'jsonc',
        'lua',
        'make',
        'markdown',
        'perl',
        'php',
        'python',
        'toml',
        'yaml'
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>'
        }
    },
    indent = {
        enable = true
    }
}
require('gitsigns').setup{}
require('material').setup({
    lualine_style = 'default'
})

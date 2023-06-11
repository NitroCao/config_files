return {
    {
        'neoclide/coc.nvim',
        branch = 'release',
        build = 'npm install',
        dependencies = { 'fannheyward/telescope-coc.nvim'},
        config = function()
            -- options for coc.nvim
            local autocmd = vim.api.nvim_create_autocmd

            autocmd({'VimEnter','Tabnew'}, {
                callback = function()
                    if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == "" then
                        vim.fn['CocActionAsync']('showOutline', 1)
                    end
                end
            })
            autocmd('BufEnter', {
                callback = function ()
                    if vim.api.nvim_get_option_value('filetype', { buf = 0}) == 'coctree' and #vim.api.nvim_list_wins() == 1 then
                        if #vim.api.nvim_list_tabpages() ~= 1 then
                            vim.api.nvim_win_close(0, false)
                        else
                            vim.cmd('bdelete')
                        end
                    end
                end
            })

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

            vim.g['coc_global_extensions'] = {
                'coc-cmake',
                'coc-json',
                'coc-yaml',
                'coc-snippets',
                'coc-pairs',
                'coc-go',
                'coc-clangd',
                'coc-pyright',
                'coc-docker',
                'coc-sh',
                '@yaegassy/coc-ansible',
            }
            vim.g['coc_filetype_map'] = {
                ['yaml.ansible'] = 'ansible',
            }

            vim.api.nvim_set_keymap('n', '<Leader>c', ':CocCommand<CR>', {})
            vim.api.nvim_set_keymap('n', 'K', [[ <Cmd>lua show_documentation()<CR> ]], { noremap = true, silent = true })
            vim.api.nvim_set_keymap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { noremap = true, silent = true, expr = true })
            vim.api.nvim_set_keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { noremap = true, silent = true, expr = true })
            vim.api.nvim_set_keymap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { noremap = true, silent = true, expr = true })
            vim.api.nvim_set_keymap('n', 'g[', '<Plug>(coc-diagnostic-prev)', { silent = true })
            vim.api.nvim_set_keymap('n', 'g]', '<Plug>(coc-diagnostic-next)', { silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gd', ':Telescope coc definitions<CR>', {})
            vim.api.nvim_set_keymap('n', '<Leader>gD', ':Telescope coc type-definitions<CR>', {})
            vim.api.nvim_set_keymap('n', '<Leader>gi', ':Telescope coc implementations<CR>', {})
            vim.api.nvim_set_keymap('n', '<Leader>gn', '<Plug>(coc-rename)', {})
            vim.api.nvim_set_keymap('n', '<Leader>gr', ':Telescope coc references<CR>', {})
            vim.api.nvim_set_keymap('n', '<Leader>gci', ': call CocAction("showIncomingCalls")', {})
            vim.api.nvim_set_keymap('n', '<Leader>gco', 'call CocAction("showOutgoingCalls")', {})
        end
    }
}

return {
    {
        'neoclide/coc.nvim',
        branch = 'release',
        build = 'npm install',
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
                elseif vim.tbl_contains({ 'vim', 'help' }, vim.o.filetype) then
                    vim.cmd('h ' .. vim.fn.expand('<cword>'))
                end
            end

            vim.g['coc_global_extensions'] = {
                'coc-json',
                'coc-yaml',
                'coc-snippets',
                'coc-go',
                'coc-clangd',
                '@yaegassy/coc-ty',
                'coc-docker',
                'coc-sh',
                'coc-tsserver',
                'coc-markdownlint',
            }
            vim.g['coc_filetype_map'] = {
                ['yaml.ansible'] = 'ansible',
            }

            vim.keymap.set('n', '<Leader>c', ':CocCommand<CR>', { silent = true, desc = 'CocCommand' })
            vim.keymap.set('n', 'K', _G.show_documentation, { silent = true, desc = 'Hover documentation' })
            vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { expr = true, silent = true })
            vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true, silent = true })
            vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { expr = true, silent = true })
            vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true, desc = 'Previous diagnostic' })
            vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true, desc = 'Next diagnostic' })
            vim.keymap.set('n', '<Leader>fs', ':Telescope coc document_symbols<CR>', { silent = true, desc = 'Document symbols' })
            vim.keymap.set('n', '<Leader>gd', ':Telescope coc definitions<CR>', { silent = true, desc = 'Go to definition' })
            vim.keymap.set('n', '<Leader>gD', ':Telescope coc type-definitions<CR>', { silent = true, desc = 'Go to type definition' })
            vim.keymap.set('n', '<Leader>gi', ':Telescope coc implementations<CR>', { silent = true, desc = 'Go to implementation' })
            vim.keymap.set('n', '<Leader>gr', ':Telescope coc references<CR>', { silent = true, desc = 'Find references' })
            vim.keymap.set('n', '<Leader>gn', '<Plug>(coc-rename)', { silent = true, desc = 'Rename symbol' })
            vim.keymap.set('n', '<Leader>gci', function()
                vim.fn.CocActionAsync('showIncomingCalls')
            end, { silent = true, desc = 'Show incoming calls' })
            vim.keymap.set('n', '<Leader>gco', function()
                vim.fn.CocActionAsync('showOutgoingCalls')
            end, { silent = true, desc = 'Show outgoing calls' })
        end
    }
}

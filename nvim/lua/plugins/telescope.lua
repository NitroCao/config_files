return {
    { 'nvim-telescope/telescope-project.nvim' },
    { 'fannheyward/telescope-coc.nvim' },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = false
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim',
        },
        lazy = false,
        version = '0.1.6',
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')
            local project_actions = require('telescope._extensions.project.actions')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fu', telescope.extensions.undo.undo, {})

            telescope.setup({
                extensions = {
                    coc = {
                        theme = 'dropdown',
                        prefer_locations = false,
                        push_cursor_on_edit = true,
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                    project = {
                        base_dirs = {
                            { path = '~/Development', max_depth = 2 }
                        },
                        hidden_files = true,
                        theme = 'dropdown',
                        order_by = 'asc',
                        search_by = 'title',
                        on_project_selected = function (prompt_bufnr)
                            project_actions.change_working_directory(prompt_bufnr, false)
                            builtin.find_files()
                        end
                    }
                },
            })
            telescope.load_extension('coc')
            telescope.load_extension('fzf')
            telescope.load_extension('undo')
            telescope.load_extension('project')
        end
    }
}

return {
    { 'nvim-tree/nvim-web-devicons' },
    { 'tpope/vim-surround' },
    { 'numToStr/Comment.nvim', lazy = false, config = function()
        require('Comment').setup({})
    end
    },
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function()
        require('gitsigns').setup({
            linehl = true,
            culhl = true,
            on_attach = function (bufnr)
                local gitsigns = require('gitsigns')

                vim.keymap.set('n', '<Leader>gbl', gitsigns.toggle_current_line_blame, { noremap = true, silent = true, desc = '[git] git blame current line' })
                vim.keymap.set('n', '<Leader>gh[', function()
                    gitsigns.nav_hunk('prev')
                end, { noremap = true, silent = true, desc = '[git] jump to previous hunk' })
                vim.keymap.set('n', '<Leader>gh]', function()
                    gitsigns.nav_hunk('next')
                end, { noremap = true, silent = true, desc = '[git] jump to next hunk' })
                vim.keymap.set('n', '<Leader>ghS', gitsigns.stage_buffer, { noremap = true, silent = true, desc = '[git] stage current buffer' })
                vim.keymap.set('n', '<Leader>ghs', gitsigns.stage_hunk, { noremap = true, silent = true, desc = '[git] stage current hunk' })
                vim.keymap.set('n', '<Leader>ghp', gitsigns.preview_hunk, { noremap = true, silent = true, desc = '[git] preview current hunk' })
                vim.keymap.set('n', '<Leader>ghr', gitsigns.reset_hunk, { noremap = true, silent = true, desc = '[git] reset current hunk' })
                vim.keymap.set('n', '<Leader>ghR', gitsigns.reset_buffer, { noremap = true, silent = true, desc = '[git] reset hunks in current buffer' })
                vim.keymap.set('n', '<Leader>ghd', gitsigns.diffthis, { noremap = true, silent = true, desc = '[git] show diff of current buffer' })
            end
        })
    end },
    { 'honza/vim-snippets', lazy = false, },
    { 'catppuccin/nvim', name = "catppuccin", config = function()
        require('catppuccin').setup({
            flavor = 'mocha',
            no_italic = false,
            no_bold = false,
            float = {
                transparent = false,
                solid = false,
            },
            custom_highlights = function(colors)
                return {
                    GitSignsAdd = { style = { "bold" } },
                    GitSignsChange = { style = { "bold" } },
                }
            end,
            integrations = {
                gitsigns = true,
                nvimtree = true,
                telescope = {
                    enabled = true,
                    style = 'nvchad',
                },
                coc_nvim = true,
                treesitter = true,
            }
        })
        vim.cmd.colorscheme 'catppuccin'
    end },
    { 'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            delay = 1000,
        },
        keys = {
            {
                '<leader>?',
                function ()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
    { 'folke/twilight.nvim' },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        config = function ()
            require('noice').setup({
                cmdline = {
                    enabled = true,
                    view = 'cmdline_popup',
                    opts = {

                    }
                },
                presets = {
                    bottom_search = false,
                    command_palette = false,
                    long_message_to_split = true,
                },
                documentation = {
                    view = 'hover',
                },
            })
        end
    }
}


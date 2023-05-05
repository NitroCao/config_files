return {
    { 'nvim-tree/nvim-web-devicons' },
    { 'tpope/vim-surround' },
    { 'numToStr/Comment.nvim', lazy = false, config = function()
        require('Comment').setup({})
    end
    },
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function()
        require('gitsigns').setup({})
    end },
    { 'honza/vim-snippets', lazy = false, },
    { 'catppuccin/nvim', name = "catppuccin", config = function()
        require('catppuccin').setup({
            flavor = 'mocha',
            no_italic = false,
            no_bold = false,
            integrations = {
                gitsigns = true,
                nvimtree = true,
                telescope = true,
            }
        })
        vim.cmd.colorscheme 'catppuccin'
    end },
}


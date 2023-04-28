return {
    { 'L3MON4D3/LuaSnip' },
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
    { 'marko-cerovac/material.nvim', config = function()
        lualine_style = 'default'
        vim.g.material_style = 'darker'
        vim.cmd 'colorscheme material'
    end },
}


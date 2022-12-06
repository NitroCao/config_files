vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])
return require('packer').startup(function()
    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-document-symbol' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'fatih/vim-go' }
    use { 'nvim-tree/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use { 'fannheyward/telescope-coc.nvim' }
    use { 'wbthomason/packer.nvim' }
    use { 'Yggdroot/Leaderf', run = ':LeaderfInstallCExtension' }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }
    use { 'tpope/vim-surround' }
    use { 'dracula/vim', as = 'dracula' }
    use { 'numToStr/Comment.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'honza/vim-snippets' }
    use { 'marko-cerovac/material.nvim' }
end)


vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])
return require('packer').startup(function()
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use { 'fannheyward/telescope-coc.nvim' }
    use { 'wbthomason/packer.nvim' }
    use { 'Yggdroot/Leaderf', run = ':LeaderfInstallCExtension' }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }
    use { 'tpope/vim-surround' }
    use { 'dracula/vim', as = 'dracula' }
    use { 'neoclide/coc.nvim', branch = 'release' }
    use { 'numToStr/Comment.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'honza/vim-snippets' }
    use { 'marko-cerovac/material.nvim' }
end)


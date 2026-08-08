require('gui')

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
vim.o.hidden = true
vim.o.signcolumn = 'yes'
vim.o.matchpairs = vim.o.matchpairs .. ',<:>,(:),[:],{:},.:.'
vim.cmd('hi clear signcolumn')
vim.o.cursorcolumn = true
vim.o.termguicolors = true
vim.wo.cursorline = true
vim.o.exrc = true
vim.cmd([[
    hi clear CursorLine
    hi clear SignColumn
    hi CursorLineNr guifg=Red
]])

vim.g.python3_host_prog = '/usr/bin/python3'

vim.keymap.set('n', '<Leader>q', ':q<CR>', { silent = true, desc = 'Quit' })
vim.keymap.set('n', '<Leader>ww', ':w<CR>', { silent = true, desc = 'Save' })
vim.keymap.set('n', '<Leader>x', ':x<CR>', { silent = true, desc = 'Save and quit' })
vim.keymap.set('n', '<C-n>', ':bn<CR>', { silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<C-p>', ':bp<CR>', { silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<Leader>bd', ':bd<CR>', { silent = true, desc = 'Delete buffer' })
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<M-b>', '<S-Left>')
vim.keymap.set('c', '<M-f>', '<S-Right>')

vim.cmd([[
augroup group1
    autocmd!

    autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2
    autocmd BufWritePre *.java,*.py,*.go,*.yml,*.yaml :silent! call CocActionAsync('format')
    autocmd BufWritePre *.java,*.go,*.py :silent! call CocActionAsync('runCommand', 'editor.action.organizeImport')
    autocmd BufWritePre *.py :silent! call CocActionAsync('runCommand', 'python.sortImports')
augroup END
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    performance = {
        rtp = {
            reset = false,
        }
    }
})

require('config.json').setup()

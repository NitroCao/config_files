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

if os.getenv('HOMEBREW_PREFIX') == nil then
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
require('plugin.telescope')
require('plugin.treesitter')
require('plugin.coc')
require('plugin.leaderf')
require('plugin.vimgo')
require('bufferline').setup{}
require('Comment').setup{}
require('gitsigns').setup{}
require('material').setup({
    lualine_style = 'default'
})


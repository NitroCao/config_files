-- options for Leaderf plugin
vim.api.nvim_set_var('Lf_WindowPosition', 'popup')
-- vim.api.nvim_set_var('Lf_PreviewInPopup', 1)
vim.api.nvim_set_var('Lf_ShortcutF', '<leader>lf')
vim.api.nvim_set_var('Lf_ShortcutB', '<leader>lb')
vim.api.nvim_set_var('Lf_DefaultMode', 'FullPath')
vim.g['Lf_WildIgnore'] = {
    dir = {'.svn', '.git', '.hg', 'tmp', '.build'},
    file = {'*.o', '*.so', '*.py[co]'}
}
vim.g['Lf_GtagsAutoGenerate'] = 0
vim.g['Lf_Gtagslabel'] = 'native-pygments'
vim.g['Lf_CursorBlink'] = 1
-- vim.g['Lf_PreviewCode'] = 1

vim.api.nvim_set_keymap('n', '<Leader>lF', ':LeaderfFunction<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ls', ':<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltt', ':<C-U><C-R>=printf("Leaderf tag --input %s", expand("<cword>"))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltr', ':<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltd', ':<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltn', ':<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ltn', ':<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leaderf>lm', '<C-U><C-R>=printf("Leaderf mru %s", expand("<cword>"))<CR>', { noremap = true, silent = true })

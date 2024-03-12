return {
    {
        'Yggdroot/LeaderF',
        build = ':LeaderfInstallCExtension',
        config = function()
            vim.g.Lf_WindowPosition = 'popup'
            vim.g.Lf_DefaultMode = 'FullPath'
            vim.g.Lf_GtagsAutoGenerate = 0
            vim.g.Lf_Gtagslabel = 'native-pygments'
            vim.g.Lf_WildIgnore = {
                dir = {'.svn', '.git', '.hg', 'tmp', '.build'},
                file = {'*.o', '*.so', '*.py[co]'}
            }
            vim.api.nvim_set_keymap('n', '<Leader>lF', ':LeaderfFunction<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>lf', ':LeaderfFile<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>lb', ':LeaderfBuffer<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>ltr', ':<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>ltd', ':<C-U><C-R>=printf("Leaderf gtags --auto-jump -d %s", expand("<cword>"))<CR>', { noremap = true, silent = true })
        end
    }
}

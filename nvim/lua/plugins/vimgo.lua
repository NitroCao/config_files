return {
    {
        'fatih/vim-go',
        build = ':GoInstallBinaries',
        config = function()
            vim.g.go_highlight_types = 1
            vim.g.go_highlight_fields = 1
            vim.g.go_highlight_functions = 1
        end
    }
}

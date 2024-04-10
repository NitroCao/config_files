return {
    {
        'nvimdev/dashboard-nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                config = {
                    week_header = {
                        enable = true
                    }
                }
            })
        end
    }
}

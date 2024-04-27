return {
    {
        'nvimdev/dashboard-nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        event = 'VimEnter',
        config = function()
            local devicons = require('nvim-web-devicons')

            require('dashboard').setup({
                theme = 'doom',
                config = {
                    header = {
'██████╗ ███████╗    ███╗   ███╗██╗   ██╗███████╗███████╗██╗     ███████╗',
'██╔══██╗██╔════╝    ████╗ ████║╚██╗ ██╔╝██╔════╝██╔════╝██║     ██╔════╝',
'██████╔╝█████╗      ██╔████╔██║ ╚████╔╝ ███████╗█████╗  ██║     █████╗  ',
'██╔══██╗██╔══╝      ██║╚██╔╝██║  ╚██╔╝  ╚════██║██╔══╝  ██║     ██╔══╝  ',
'██████╔╝███████╗    ██║ ╚═╝ ██║   ██║   ███████║███████╗███████╗██║     ',
'╚═════╝ ╚══════╝    ╚═╝     ╚═╝   ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝     ',
                    },
                    center = {
                        {
                            icon = '󰏓 ',
                            desc = 'Projects',
                            key = 'p',
                            action = 'Telescope project',
                        },
                        {
                            icon = devicons.get_icon_by_filetype('vim', {}) .. ' ',
                            desc = 'Neovim Config',
                            key = ',',
                            action = ':chdir ~/.dotfiles/nvim | edit lua/init.lua',
                        },
                        {
                            icon = '󰒲 ',
                            desc = 'Lazy',
                            key = 'l',
                            action = ':Lazy',
                        },
                    }
                }
            })
        end
    }
}

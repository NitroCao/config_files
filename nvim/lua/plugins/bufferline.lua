return {
    {
        'akinsho/bufferline.nvim',
        version = '*',
        after = "catppuccin",
        config = function()
            local mocha = require("catppuccin.palettes").get_palette "mocha"
            require("bufferline").setup {
                highlights = require("catppuccin.special.bufferline").get_theme{
                    styles = {"italic", "bold"},
                    custom = {
                        all = {
                            fill = { bg = "#000000" },
                        },
                        mocha = {
                            background = { fg = mocha.text },
                        },
                        latte = {
                            background = { fg = "#000000" },
                        },
                    }
                }
            }
        end
    }
}

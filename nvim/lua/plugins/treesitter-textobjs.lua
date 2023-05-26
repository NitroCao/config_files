return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        priority = 0,
        lazy = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = function ()
            local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

            require('nvim-treesitter.configs').setup{
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["ic"] = "@conditional.inner",
                            ["ac"] = "@conditional.outer",
                            ["ip"] = "@parameter.inner",
                            ["ap"] = "@parameter.outer",
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@conditional.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@conditional.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@conditional.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@conditional.outer",
                        }
                    }
                }
            }
        end
    }
}

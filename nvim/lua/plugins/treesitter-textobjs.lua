return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        priority = 0,
        lazy = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = function ()
            local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
            -- 新版只提供 builtin_f_expr 等函数，且必须带 { expr = true }
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

            require('nvim-treesitter-textobjects').setup {
                select = {
                    -- 新版不再支持 keymaps，键位需要自己用 vim.keymap.set 绑定
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            }

            -- select 文本对象
            local select = require('nvim-treesitter-textobjects.select')
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@conditional.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ip", function()
                select.select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ap", function()
                select.select_textobject("@parameter.outer", "textobjects")
            end)

            -- move 跳转
            local move = require('nvim-treesitter-textobjects.move')
            local function bind_move(mapping, fn, query)
                vim.keymap.set({ "n", "x", "o" }, mapping, function()
                    fn(query, "textobjects")
                end)
            end

            bind_move("]f", move.goto_next_start, "@function.outer")
            bind_move("]c", move.goto_next_start, "@conditional.outer")
            bind_move("]p", move.goto_next_start, "@parameter.outer")
            bind_move("]F", move.goto_next_end, "@function.outer")
            bind_move("]C", move.goto_next_end, "@conditional.outer")
            bind_move("]P", move.goto_next_end, "@parameter.outer")
            bind_move("[f", move.goto_previous_start, "@function.outer")
            bind_move("[c", move.goto_previous_start, "@conditional.outer")
            bind_move("[p", move.goto_previous_start, "@parameter.outer")
            bind_move("[F", move.goto_previous_end, "@function.outer")
            bind_move("[C", move.goto_previous_end, "@conditional.outer")
            bind_move("[P", move.goto_previous_end, "@parameter.outer")
        end
    }
}

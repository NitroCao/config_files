return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        config = function()
            -- 新版 nvim-treesitter（main 分支）只支持 install_dir 这一个 setup 选项，
            -- highlight / incremental_selection / indent 等旧配置项已被移除。
            require('nvim-treesitter').setup {
                -- install_dir = vim.fn.stdpath('data') .. '/site', -- 默认值，可省略
            }

            local ensure_installed = {
                'bash',
                'c',
                'cmake',
                'cpp',
                'dockerfile',
                'go',
                'gomod',
                'html',
                'java',
                'javascript',
                'json',
                'json5',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'perl',
                'php',
                'python',
                'regex',
                'toml',
                'yaml',
                -- 高亮 vim 配置 / 帮助文档 / query 文件
                'vim',
                'vimdoc',
                'query',
            }

            local installed = require('nvim-treesitter').get_installed()
            local parsers_to_install = vim.iter(ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(installed, parser)
                end)
                :totable()

            if #parsers_to_install > 0 then
                -- 异步安装缺失的 parser；之后可用 :TSInstall <lang> / :TSUpdate 手动管理
                require('nvim-treesitter').install(parsers_to_install)
            end

            -- 新版不再通过 setup 开启高亮，改为调用 Neovim 核心的 treesitter 高亮
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end
    }
}

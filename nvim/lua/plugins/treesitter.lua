return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup{
                ensure_installed = {
                    'bash',
                    'c',
                    'cmake',
                    'cpp',
                    'dockerfile',
                    'go',
                    'gomod',
                    'json',
                    'json5',
                    'jsonc',
                    'lua',
                    'make',
                    'markdown',
                    'perl',
                    'php',
                    'python',
                    'toml',
                    'yaml'
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        node_decremental = '<BS>',
                        scope_incremental = '<TAB>'
                    }
                },
                indent = {
                    enable = true
                }
            }
        end
    }
}

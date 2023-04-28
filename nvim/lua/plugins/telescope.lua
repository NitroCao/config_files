return {
    { 'fannheyward/telescope-coc.nvim' },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        version = '0.1.1',
        keys = {
            { '<Leader>ff', '<cmd>Telescope find_files<CR>', mode = 'n' },
            { '<Leader>fb', '<cmd>Telescope buffers<CR>', mode = 'n' },
            { '<Leader>fg', '<cmd>Telescope live_grep<CR>', mode = 'n' },
        },
        config = function()
            local telescope = require('telescope')

            telescope.setup({
                extensions = {
                    coc = {
                        theme = 'ivy',
                        prefer_locations = true,
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    }
                },
            })
            telescope.load_extension('fzf')
        end
    }
}

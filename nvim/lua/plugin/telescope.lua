local telescope = require('telescope')

telescope.setup({
    extensions = {
        coc = {
            theme = 'ivy',
            prefer_locations = true,
        }
    },
})
telescope.load_extension('coc')


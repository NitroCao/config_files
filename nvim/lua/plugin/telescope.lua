local telescope = require('telescope')
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gtd', builtin.lsp_type_definitions, {})
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>sw', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>ci', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>co', builtin.lsp_outgoing_calls, {})

telescope.setup({
    extensions = {
        coc = {
            theme = 'ivy',
            prefer_locations = true,
        }
    },
})
telescope.load_extension('coc')
telescope.load_extension('fzf')


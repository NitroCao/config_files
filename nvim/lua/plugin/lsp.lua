local lspconfig = require('lspconfig')

local opts = { noremap = true, silent = true }

local on_attach = function (client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.sumneko_lua.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true)
            },
            telemetry = {
                enable = false
            }
        }
    }
}
lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.bufls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.bashls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.dockerls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.jsonls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.yamlls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            hehavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'nvim_lua' }
    },
}

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    },
    {
        { name = 'buffer' }
    })
})

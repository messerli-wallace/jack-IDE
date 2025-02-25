-- using mason for lsp management. It doesn't seem worth it to manually install, at least right now.
-- note that clangd, while installed, does not currently work with user header files...
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"lua_ls","pyright","clangd","ts_ls","rust_analyzer"},
--    handlers = {
--       clangd = function()
--           local clangd_opts = require('').nvim_lua_ls()
--          -- Add verbose output flag to clangd
--        clangd_opts.cmd = { '/usr/bin/clangd', '--log=verbose' }
--      require('lspconfig').clangd.setup(clangd_opts)
-- end,
-- }

})

local on_attach = function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}
  -- remaps, most are default
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-i>", function() vim.lsp.buf.signature_help() end, opts)
end

local lsp_flags = {
    debounce_text_changes = 150, --150 is default. Debounce didChange notifications to the server by the given number in milliseconds. No debounce occurs if nil.
}

-- specific lsp setup
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim"},
            },
        },
    },
}
lspconfig.clangd.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
lspconfig.pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
lspconfig.ts_ls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
lspconfig.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        ['rust-analyzer'] = {
        diagnostics = {
            enable = true,
            experimental = {
                enable = true,
                }
            }
        }
    }
}

-- cmp: autocomplete and stuff
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})


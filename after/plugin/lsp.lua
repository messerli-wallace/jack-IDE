--local lsp_zero = require('lsp-zero')
--
--lsp_zero.on_attach(function(client, bufnr)
--  local opts = {buffer = bufnr, remap = false}
--
--  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--end)
--
---- to learn how to use mason.nvim with lsp-zero
---- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
--require('mason').setup({})
--
---- Load lsp-zero and configure language servers
--require('lsp-zero').on_attach(function(client, bufnr)
--    -- Set up default keymaps for the buffer
--    require('lsp-zero').default_keymaps({buffer = bufnr})
--end)
--
---- Load mason-lspconfig for automatic server setup
--require('mason-lspconfig').setup({
--    ensure_installed = {'tsserver', 'rust_analyzer'},
--    handlers = {
--        lua_ls = function()
--            local lua_opts = require('lsp-zero').nvim_lua_ls()
--            require('lspconfig').lua_ls.setup(lua_opts)
--        end,
--        clangd = function()
--            local clangd_opts = require('lsp-zero').nvim_lua_ls()
--            -- Add verbose output flag to clangd
--            clangd_opts.cmd = { '/usr/bin/clangd', '--log=verbose' }
--            require('lspconfig').clangd.setup(clangd_opts)
--        end,
--    }
--})
--
--local cmp = require('cmp')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
--
---- this is the function that loads the extra snippets to luasnip
---- from rafamadriz/friendly-snippets
--require('luasnip.loaders.from_vscode').lazy_load()
--
--cmp.setup({
--  sources = {
--    {name = 'path'},
--    {name = 'nvim_lsp'},
--    {name = 'nvim_lua'},
--    {name = 'luasnip', keyword_length = 2},
--    {name = 'buffer', keyword_length = 3},
--  },
--  formatting = lsp_zero.cmp_format({details = false}),
--  mapping = cmp.mapping.preset.insert({
--    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--    ['<C-Space>'] = cmp.mapping.complete(),
--  }),
--})


require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"lua_ls","pylsp"},
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

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end


require("lspconfig").lua_ls.setup{}
--require("lspconfig").clangd.setup{
    --settings = {
      --  cmd={"-ferror-limit=0"}
    --}}
require("lspconfig").pylsp.setup{}


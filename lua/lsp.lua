local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local buf = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf)
  vim.keymap.set("n", "K",  vim.lsp.buf.hover, buf)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf)
end

local caps = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then caps = cmp_lsp.default_capabilities(caps) end

-- TypeScript / Remix
lspconfig.ts_ls.setup{
  on_attach = on_attach,
  capabilities = caps,
}
lspconfig.eslint.setup{
  on_attach = on_attach,
  capabilities = caps,
}

-- Tailwind CSS
lspconfig.tailwindcss.setup{
  on_attach = on_attach,
  capabilities = caps,
}

-- Lua LSP for editing your config
lspconfig.lua_ls.setup{
  on_attach = on_attach,
  capabilities = caps,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace   = { checkThirdParty = false },
    },
  },
}
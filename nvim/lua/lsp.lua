local servers = {
  clangd = {},
  rust_analyzer = {},
  kotlin_lsp = {},
  expert = {},
  lua_ls = {},
  teal_ls = {},
  -- emmylua_ls = {},
  denols = {},
  ty = {},
  phpactor = {},
  -- bashls = {},
  -- html = {},
  -- cssls = {},
  tailwindcss = {},
  taplo = {},
  texlab = {},
  tinymist = {},
}

for server, settings in pairs(servers) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end

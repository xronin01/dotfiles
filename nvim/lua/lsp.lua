local servers = {
  clangd = {},
  rust_analyzer = {},
  kotlin_lsp = {},
  expert = {},
  lua_ls = {},
  teal_ls = {},
  -- emmylua_ls = {},
  denols = {},
  -- ty = {},
  pyrefly = {},
  phpactor = {},
  -- bashls = {},
  -- html = {},
  -- cssls = {},
  -- superhtml = {},
  tailwindcss = {},
  taplo = {},
  -- tombi = {},
  texlab = {},
  tinymist = {},
}

for server, settings in pairs(servers) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end

local lsp_servers = { "omnisharp", "bashls", "cssmodules_ls", "sqlls",
"powershell_es", "sumneko_lua", "tsserver", "lemminx", "yamlls" }

for _, name in ipairs(lsp_servers) do
  local ok, server = require("nvim-lsp-installer.servers").get_server(name)

  if ok and not server:is_installed() then
    print("Installing LSP server " .. name)
    server:install()
  end
end
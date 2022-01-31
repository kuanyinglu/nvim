-- local lsp_servers = { "bashls", "cssmodules_ls", "powershell_es", 
local lsp_servers = { 
"sqlls", "omnisharp", "sumneko_lua", "tsserver", "lemminx", "yamlls" }

for _, name in ipairs(lsp_servers) do
  local ok, server = require("nvim-lsp-installer.servers").get_server(name)

  if ok and not server:is_installed() then
    print("Installing LSP server " .. name)
    server:install()
  end
end

local lsp_installer = require("nvim-lsp-installer")

local m = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd> " .. result .. "<cr>", {
        noremap = true,
        silent = true,
    })
end


lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        flags = {
            debounce_text_changes = 150,
        },
    }
    server:setup(opts)
end)
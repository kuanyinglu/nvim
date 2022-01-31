local m = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd> " .. result .. "<cr>", {
        noremap = true,
        silent = true,
    })
end
m("n", "<leader>ff", "Telescope find_files")
m("n", "<leader>fo", "Telescope oldfiles")
m("n", "<leader>fg", "Telescope live_grep")
m("n", "<leader>fb", "Telescope buffers")
m("n", "<leader>fc", "Telescope neoclip")
m("n", "<leader>fj", "Telescope jumplist")
m("n", "<leader>ft", "Telescope treesitter")

m("n", "<leader>lr", "Telescope lsp_references")
m("n", "<leader>ls", "Telescope lsp_document_symbols")
m("n", "<leader>lS", "Telescope lsp_workspace_symbols")
m("n", "<leader>la", "Telescope lsp_code_actions")
m("n", "<leader>lD", "Telescope diagnostics")
m("n", "<leader>li", "Telescope lsp_implementations")
m("n", "<leader>ld", "Telescope lsp_definitions")
m("n", "<leader>lt", "Telescope lsp_type_definitions")

m("n", "<leader>gs", "Telescope git_status")
m("n", "<leader>gS", "Telescope git_stash")
m("n", "<leader>gB", "Telescope git_branches")
m("n", "<leader>gb", "Telescope git_bcommits")

require("which-key").setup {
}
local m = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd> " .. result .. "<cr>", {
        noremap = true,
        silent = true,
    })
end
m("n", "<C-_>", "WhichKey")
m("v", "<C-_>", "WhichKey v")
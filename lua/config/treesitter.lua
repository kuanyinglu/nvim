local M = {}
M.setup = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "maintained"
    })
end
return M
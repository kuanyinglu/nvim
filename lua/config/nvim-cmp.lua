local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
  },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'treesitter' },
        { name = 'path' }
    }, {
        { name = 'buffer' },
    })

})

require("luasnip.loaders.from_vscode").lazy_load()

-- local function prequire(...)
-- local status, lib = pcall(require, ...)
-- if (status) then return lib end
--     return nil
-- end

-- local luasnip = prequire('luasnip')
-- local cmp = prequire("cmp")

-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local check_back_space = function()
--     local col = vim.fn.col('.') - 1
--     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         return true
--     else
--         return false
--     end
-- end

-- _G.tab_complete = function()
--     if cmp and cmp.visible() then
--         cmp.select_next_item()
--     elseif luasnip and luasnip.expand_or_jumpable() then
--         return t("<Plug>luasnip-expand-or-jump")
--     elseif check_back_space() then
--         return t "<Tab>"
--     else
--         cmp.complete()
--     end
--     return ""
-- end
-- _G.s_tab_complete = function()
--     if cmp and cmp.visible() then
--         cmp.select_prev_item()
--     elseif luasnip and luasnip.jumpable(-1) then
--         return t("<Plug>luasnip-jump-prev")
--     else
--         return t "<S-Tab>"
--     end
--     return ""
-- end

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
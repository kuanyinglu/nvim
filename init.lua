-- for debug
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

local disable_distribution_plugins = function()
    vim.g.loaded_gzip              = 1
    vim.g.loaded_tar               = 1
    vim.g.loaded_tarPlugin         = 1
    vim.g.loaded_zip               = 1
    vim.g.loaded_zipPlugin         = 1
    vim.g.loaded_getscript         = 1
    vim.g.loaded_getscriptPlugin   = 1
    vim.g.loaded_vimball           = 1
    vim.g.loaded_vimballPlugin     = 1
    vim.g.loaded_matchit           = 1
    vim.g.loaded_matchparen        = 1
    vim.g.loaded_2html_plugin      = 1
    vim.g.loaded_logiPat           = 1
    vim.g.loaded_rrhelper          = 1
    vim.g.loaded_netrw             = 1
    vim.g.loaded_netrwPlugin       = 1
    vim.g.loaded_netrwSettings     = 1
    vim.g.loaded_netrwFileHandlers = 1
end

local packer = require("packer")
-- git
packer.use({"lambdalisue/gina.vim", opt = true})
-- db
packer.use({"tpope/vim-dadbod", opt = true})
packer.use({"kristijanhusak/vim-dadbod-ui", opt = true})
-- editor config
packer.use({"editorconfig/editorconfig-vim", opt = true})
-- cursor/motion
packer.use({"itchyny/vim-cursorword"})
packer.use({"kuanyinglu/vim-momentum"})
packer.use({"kuanyinglu/vim-hop"})
-- text object
-- todo - use user text objects to replce targets.vim
packer.use({"wellle/targets.vim"})
packer.use({"kana/vim-textobj-user"})
packer.use({"tpope/vim-surround"})
-- lspinstall doesn't work well with windows
-- packer.use({"anott03/nvim-lspinstall"})
-- find and replace
packer.use({"windwp/nvim-spectre", opt = true})
-- buffer navigation
packer.use({"simrat39/symbols-outline.nvim", opt = true})
packer.use({"nvim-treesitter/playground", opt = true})
vim.cmd('set undofile')
vim.api.nvim_set_keymap('n', 'J', '<C-d>', {silent = true})
vim.api.nvim_set_keymap('n', 'K', '<C-u>', {silent = true})
vim.api.nvim_set_keymap('n', 'U', '<C-r>', {silent = true})
vim.api.nvim_set_keymap('n', 'ss', '<Plug>(vim-momentum-start)', {})
vim.api.nvim_set_keymap('x', 'ss', '<Plug>(vim-momentum-vstart)', {})
vim.api.nvim_set_keymap('n', 'sh', '<Plug>(vim-hop-start)', {})
vim.api.nvim_set_keymap('x', 'sh', '<Plug>(vim-hop-vstart)', {})

vim.cmd("autocmd User targets#mappings#user call targets#mappings#extend({\z
    '(': {'pair': [{'o': '(', 'c': ')'}]}, \z
    ')': {'pair': [{'o': '(', 'c': ')'}]}, \z
    '{': {'pair': [{'o': '{', 'c': '}'}]}, \z
    '}': {'pair': [{'o': '{', 'c': '}'}]}, \z
    '[': {'pair': [{'o': '[', 'c': ']'}]}, \z
    ']': {'pair': [{'o': '[', 'c': ']'}]}, \z
    '<': {'pair': [{'o': '<', 'c': '>'}]}, \z
    '>': {'pair': [{'o': '<', 'c': '>'}]}, \z
    '\"': {'quote': [{'d': '\"'}]}, \z
    \"'\": {'quote': [{'d': \"'\"}]}, \z
    '`': {'quote': [{'d': '`'}]}, \z
    ',': {'separator': [{'d': ','}]}, \z
    '.': {'separator': [{'d': '.'}]}, \z
    ';': {'separator': [{'d': ';'}]}, \z
    ':': {'separator': [{'d': ':'}]}, \z
    '+': {'separator': [{'d': '+'}]}, \z
    '-': {'separator': [{'d': '-'}]}, \z
    '=': {'separator': [{'d': '='}]}, \z
    '~': {'separator': [{'d': '~'}]}, \z
    '_': {'separator': [{'d': '_'}]}, \z
    '*': {'separator': [{'d': '*'}]}, \z
    '#': {'separator': [{'d': '#'}]}, \z
    '/': {'separator': [{'d': '/'}]}, \z
    '\\': {'separator': [{'d': '\\'}]}, \z
    '|': {'separator': [{'d': '|'}]}, \z
    '&': {'separator': [{'d': '&'}]}, \z
    '$': {'separator': [{'d': '$'}]}, \z
    't': {'tag': [{}]}, \z
    'a': {'argument': [{'o': '[([]', 'c': '[])]', 's': ','}]}, \z
    'b': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}]}, \z
    'q': {'quote': [{'d':\"'\"}, {'d':'\"'}, {'d':'`'}]}, \z
    })")

local omnisharp_bin = vim.fn.stdpath("data") .. "\\lspinstall\\omnisharp\\OmniSharp.exe"
require'lspconfig'.omnisharp.setup {
    cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()), "RoslynExtensionsOptions:EnableAnalyzersSupport=true"},
    on_attach = require'lsp'.common_on_attach,
    -- filetypes = { "cs", "vb" },
    root_dir = require('lspconfig/util').root_pattern("*.sln")
}

--npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup {
    cmd = {"typescript-language-server.cmd", "--stdio"},
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    on_attach = require'lsp'.tsserver_on_attach,
    -- This makes sure tsserver is not used for formatting (I prefer prettier)
    -- on_attach = require'lsp'.common_on_attach,
    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = {documentFormatting = false},
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.tsserver.diagnostics.virtual_text,
            signs = O.tsserver.diagnostics.signs,
            underline = O.tsserver.diagnostics.underline,
            update_in_insert = true

        })
    }
}
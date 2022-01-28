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

-- add yank to register
local currentRegister = 'z'
local alphabet = 'abcdefghijklmnopqrstuvwxyz'
function putYankTextInRegister()
    if vim.v['event']['regname'] == '+' or vim.v['event']['regname'] == '*' then
        vim.cmd('call setreg("'.. currentRegister .. '", getreg("' .. vim.v['event']['regname'] .. '"))')
        local index = string.find(alphabet, currentRegister)
        index = (index % string.len(alphabet)) + 1
        currentRegister = string.sub(alphabet, index, index)
    end
end
vim.cmd("augroup initLua")
vim.cmd("autocmd TextYankPost * lua putYankTextInRegister()")
vim.cmd("augroup END")

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

local packer = require("packer").startup(function()
-- dependencies
use{'wbthomason/packer.nvim'}
use{"nvim-lua/popup.nvim"}
use{"nvim-lua/plenary.nvim"}
use{"kyazdani42/nvim-web-devicons"}
-- git
use{"lambdalisue/gina.vim", opt = true, cmd = {"Gina"}}
-- db
use{"tpope/vim-dadbod", opt = true}
use{"kristijanhusak/vim-dadbod-ui", opt = true}
-- editor config
use{"editorconfig/editorconfig-vim", opt = true}
-- fixes
use{"antoinemadec/FixCursorHold.nvim"}
-- cursor/motion
use{"itchyny/vim-cursorword"}
use{"kuanyinglu/vim-textobj"}
use{"ggandor/lightspeed.nvim"}
-- lsp installer
use{"williamboman/nvim-lsp-installer"}
use{"hrsh7th/cmp-nvim-lsp"}
use{"neovim/nvim-lspconfig"}
use{"tamago324/nlsp-settings.nvim"}
use{"jose-elias-alvarez/null-ls.nvim"}
use{"williamboman/nvim-lsp-installer"}
-- quickfix
use{"kevinhwang91/nvim-bqf", opt = true}
-- buffer navigation
use{"simrat39/symbols-outline.nvim", opt = true}
use{"nvim-treesitter/playground", opt = true, cmd = {"TSPlaygroundToggle"}}
use{"lewis6991/gitsigns.nvim", opt = true, cmd = {"TSPlaygroundToggle"}}
-- utilities
use{"nvim-telescope/telescope.nvim", opt = true}
use{"nvim-telescope/telescope-fzf-native.nvim", opt = true}
use{"folke/which-key.nvim", opt = true}
use{"mg979/vim-visual-multi",}
-- completion
use{"hrsh7th/nvim-cmp"}
use{"rafamadriz/friendly-snippets"}
use{"L3MON4D3/LuaSnip"}
-- treesitter
use{"nvim-treesitter/nvim-treesitter"}
-- directory
use{"kyazdani42/nvim-tree.lua", opt = true}
-- project
use{"ahmedkhalf/project.nvim", opt = true}
-- status
use{"nvim-lualine/lualine.nvim"}
use{"romgrk/barbar.nvim"}
-- debugging
use{"mfussenegger/nvim-dap", opt = true}
use{"Pocco81/DAPInstall.nvim", opt = true}
-- terminal
use{"akinsho/toggleterm.nvim"}
end)


vim.cmd('set undofile')

--Keymappings
vim.api.nvim_set_keymap('n', 'J', '<C-d>', {silent = true})
vim.api.nvim_set_keymap('n', 'K', '<C-u>', {silent = true})
vim.api.nvim_set_keymap('n', 'U', '<C-r>', {silent = true})
vim.api.nvim_set_keymap('n', 'gh', '<C-r>', {silent = true})
vim.api.nvim_set_keymap('c', '<C-j>', '<C-n>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('c', '<C-k>', '<C-p>', { noremap = true, silent = true})
vim.o.timeoutlen = 1000


--Paste without moving cursor
vim.cmd('command! -bar -bang -range -register Put call append(<line2> - <bang>0, getreg(<q-reg>, 1, 1))')


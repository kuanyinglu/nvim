if not vim.g.vscode then
    local key_mapper = function(mode, key, result)
        vim.api.nvim_set_keymap(
          mode,
          key,
          result,
          {noremap = true, silent = true}
        )
    end
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

    local util = require("packer.util")
    local packer = require("packer").startup({function()
        -- dependencies
        use{'wbthomason/packer.nvim'}
        use{"nvim-lua/popup.nvim"}
        use{"nvim-lua/plenary.nvim"}
        use{"kyazdani42/nvim-web-devicons"}
        -- git
        use{"tpope/vim-fugitive"}
        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require('gitsigns').setup()
            end
        }
        -- db
        use{"tpope/vim-dadbod"}
        use{"kristijanhusak/vim-dadbod-ui"}
        -- editor config
        use{"editorconfig/editorconfig-vim"}
        -- fixes
        use{"antoinemadec/FixCursorHold.nvim"}
        -- cursor/motion
        use {
              "ggandor/lightspeed.nvim",
              event = "BufRead",
        }
        use {
              "kuanyinglu/vim-textobj",
              event = "BufRead",
        }
        use {
              "itchyny/vim-cursorword",
              event = "BufRead",
        }
        -- lsp installer
        use{
            "williamboman/nvim-lsp-installer",
            after = "cmp-nvim-lsp",
            config = function()
                require('config.nvim-lsp-installer')
            end
        }
        use{"neovim/nvim-lspconfig"}
        use{"tamago324/nlsp-settings.nvim"}
        use{"jose-elias-alvarez/null-ls.nvim"}
        -- quickfix
        use{"kevinhwang91/nvim-bqf"}
        -- buffer navigation
        use {
            "nvim-treesitter/playground",
            cmd = "TSPlaygroundToggle"
        }
        use{"ray-x/navigator.lua"}
        -- utilities
        use {
            "nvim-telescope/telescope.nvim",
            config = function()
              require("config.telescope")
            end
        }
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = 'make'
        }
        use {
            "AckslD/nvim-neoclip.lua",
            after = "telescope.nvim",
            config = function()
                require('neoclip').setup()
                require('telescope').load_extension('neoclip')
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
              require("config.which-key")
            end
        }
        use{"mg979/vim-visual-multi"}
        use {
            "kevinhwang91/nvim-hlslens",
            config = function()
                require('hlslens').start()
            end
        }
        use {
            "petertriho/nvim-scrollbar",
            after = "nvim-hlslens",
            config = function()
                require("scrollbar").setup()
                require("scrollbar.handlers.search").setup()
            end
        }
        use{"machakann/vim-highlightedyank"}
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
        }
        -- completion
        use {
            "rafamadriz/friendly-snippets"
        }
        use {
            "L3MON4D3/LuaSnip",
            after = "friendly-snippets"
        }
        use {
            "hrsh7th/nvim-cmp",
            after = "LuaSnip",
            config = function()
                require("config.nvim-cmp")
            end
        }
        use {
            "saadparwaiz1/cmp_luasnip",
            after = "LuaSnip"
        }
        use {
            "hrsh7th/cmp-nvim-lua",
            after = "nvim-cmp"
        }
        use {
            "hrsh7th/cmp-nvim-lsp",
            after = "cmp-nvim-lua"
        }
        use {
            "hrsh7th/cmp-buffer",
            after = "cmp-nvim-lsp"
        }
        use {
            "hrsh7th/cmp-path",
            after = "cmp-buffer"
        }
        use {
            "ray-x/cmp-treesitter",
            after = "nvim-cmp"
        }
        -- treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
              require("config.treesitter")
            end
        }
        -- directory
        use {
            "kyazdani42/nvim-tree.lua",
            cmd =  { "NvimTreeToggle", "NvimTreeFocus" }
        }
        -- project
        use{"ahmedkhalf/project.nvim"}
        -- status
        use{"nvim-lualine/lualine.nvim"}
        use{"romgrk/barbar.nvim"}
        -- debugging
        use{"mfussenegger/nvim-dap"}
        use{"Pocco81/DAPInstall.nvim"}
        use {
            "nvim-telescope/telescope-dap.nvim",
            after = "telescope.nvim",
            config = function()
                require('telescope').load_extension('dap')
            end 
        }
        -- terminal
        use{"akinsho/toggleterm.nvim"}
        -- theme
        use{"morhetz/gruvbox"}
    end,
        config = {
            compile_path = util.join_paths(vim.fn.stdpath('config'), 'packer', 'packer_compiled.lua')
        }
    })

    -- default configs
    vim.opt.clipboard = "unnamedplus"
    vim.g.mapleader = " "
    vim.opt.cul = true
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.smartindent = true
    vim.opt.hidden = true
    vim.opt.mouse = "a"
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.relativenumber = false
    vim.opt.ruler = false
    vim.opt.shortmess:append "sI"
    vim.opt.number = true
    vim.opt.signcolumn = "yes"
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.tabstop = 8
    vim.opt.timeoutlen = 400
    vim.opt.undofile = true
    vim.opt.termguicolors = true
    vim.opt.updatetime = 250
    vim.opt.whichwrap:append "<>[]hl"
    vim.opt.background = "dark"
    vim.opt.showmode = false
    vim.opt.wrap = true
    vim.opt.completeopt = "menuone,noselect"
    vim.cmd('colorscheme gruvbox')

    --Neovim related mappings

    vim.api.nvim_set_keymap('n', 'J', '<C-d>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'K', '<C-u>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'U', '<C-r>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'gh', '<C-r>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('c', '<down>', 'pumvisible() ? "\\<C-n>" : "\\<down>"', { expr = true, noremap = true})
    vim.api.nvim_set_keymap('c', '<up>', 'pumvisible() ? "\\<C-p>" : "\\<up>"', { expr = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-w>', '<C-w>j', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-left>', '<C-w>h', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-s>', ':<c-u>update<cr>', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-w>', '<C-w>j', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-left>', '<C-w>h', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-s>', ':<c-u>update<cr>', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true, silent = true})


    --Paste without moving cursor
    vim.cmd('source '.. util.join_paths(vim.fn.stdpath('config'), 'packer', 'packer_compiled.lua'))
else
    vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vscode/init.vim')
end
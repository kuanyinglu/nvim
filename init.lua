if not vim.g.vscode then
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

    local util = require("packer.util")
    local packer = require("packer").startup({function()
        -- -- dependencies
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
        use{"pedro757/emmet"}
        use{"tamago324/nlsp-settings.nvim"}
        use{"jose-elias-alvarez/null-ls.nvim"}
        -- quickfix
        -- buffer navigation
        use {
            "nvim-treesitter/playground",
            cmd = "TSPlaygroundToggle"
        }
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
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
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
            cmd =  { "NvimTreeToggle", "NvimTreeFocus" },
            config = function()
                require("config.nvim-tree")
              end
  
        }
        -- project
        use {
            "ahmedkhalf/project.nvim",
            after = "telescope.nvim",
            config = function()
                require("project_nvim").setup()
                require('telescope').load_extension('projects')
            end
        }
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
    
    vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'J', '<C-d>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'K', '<C-u>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'U', '<C-r>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'H', '<C-l>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('c', '<down>', 'pumvisible() ? "\\<C-n>" : "\\<down>"', { expr = true, noremap = true})
    vim.api.nvim_set_keymap('c', '<up>', 'pumvisible() ? "\\<C-p>" : "\\<up>"', { expr = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true})
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
    vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true})

    local m = function(mode, key, result)
        vim.api.nvim_set_keymap(mode, key, "<cmd> " .. result .. "<cr>", {
            noremap = true,
            silent = true,
        })
      end
    --Quickfix improvement
    m("n", "<leader>qa", 'call setqflist([{ "bufnr":bufnr(), "lnum":line("."), "col":col("."), "text":getline(line("."))[col("."):] }], "a")')
    m("n", "<leader>qn", "cn")
    m("n", "<leader>qp", "cp")
    m("n", "<leader>qN", "cnf")
    m("n", "<leader>qP", "cpf")
    m("n", "<leader>qo", "copen")
    m("n", "<leader>qq", "ccl")
    m("n", "<leader>qc", "call setqflist([], 'r')<cr><cmd>ccl")
    
    --Plugin mappings
    m("n", "<leader>lh", "lua vim.lsp.buf.hover()")
    m("n", "<leader>lR", "lua vim.lsp.buf.rename()")
    m("n", "<leader>lf", "lua vim.lsp.buf.formatting()")
    m("n", "<leader>lH", "lua vim.lsp.buf.signature_help()")
      
    m("n", "<C-_>", "WhichKey")
    m("v", "<C-_>", "WhichKey v")

    m("n", "<leader>t", "NvimTreeToggle")
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


    --Paste without moving cursor
    vim.cmd('source '.. util.join_paths(vim.fn.stdpath('config'), 'packer', 'packer_compiled.lua'))
else
    vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vscode/init.vim')
end
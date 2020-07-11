call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'neomake/neomake'
Plug 'Iron-E/nvim-libmodal'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdTree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-dadbod'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
Plug 'easymotion/vim-easymotion'
call plug#end()

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smarttab
set number
set undodir=~/AppData/Local/nvim/undodir
set undofile
hi CursorLine ctermbg=242

set hidden
let g:coc_global_extensions=['coc-omnisharp', 'coc-json', 'coc-html', 'coc-css', 'coc-sql', 'coc-gitignore', 'coc-tsserver']
let g:neomake_javascript_enabled_makers = ['eslint']

command! FileNavMode execute 'luafile' stdpath('config') . '/libmodal/file-nav.lua'

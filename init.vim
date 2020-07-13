call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'neomake/neomake'
Plug 'Iron-E/nvim-libmodal'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdTree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-dadbod'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
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
let g:ale_fixers = {
            \'javascript': ['eslint']
            \}
let g:ale_fixers = { 'javascript': ['prettier'] }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

noremap s <Plug>(easymotion-db-f)
nnoremap s <Plug>(easymotion-db-f)
command! EasyMotion call EasyMotion#S(1,0,2)
command! EasyMotionX call EasyMotion#S(1,1,2)
command! EasyMotionW call EasyMotion#OverwinF(1)

command! FileNavMode execute 'luafile' stdpath('config') . '/libmodal/file-nav.lua'

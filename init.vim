call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'neomake/neomake'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'Iron-E/nvim-libmodal'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rafi/vim-denite-session'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-dadbod'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc-denite'
"Plug 'antoinemadec/coc-fzf'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'dense-analysis/ale'
"Plug 'OmniSharp/omnisharp-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim'
call plug#end()

let mapleader=" "
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smarttab
set number
set undodir=~/AppData/Local/nvim/undodir
set undofile
set mouse=a
set clipboard=unnamed
filetype plugin indent on
syntax enable
hi CursorLine ctermbg=236
hi CursorColumn ctermbg=236

set hidden
let g:coc_global_extensions=['coc-omnisharp', 'coc-json', 'coc-html', 'coc-css', 'coc-sql', 'coc-tsserver', 'coc-prettier', 'coc-snippets', 'https://github.com/kuanyinglu/coc-symbol-lists']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:ale_linters = {
            \'javascript': ['eslint'],
            \'cs': ['OmniSharp']
            \}
let g:ale_fixers = { 'javascript': ['prettier_eslint'] }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_list_window_size = 5
let g:OmniSharp_want_snippet = 1
let g:OmniSharp_server_stdio = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:airline#extensions#coc#enabled = 1
let g:surround_no_mappings=1
let g:fugitive_no_maps = 1
let g:fruzzy#usenative = 1
let g:yankstack_yank_keys = ['y', 'Y']

hi EasyMotionTargetDefault ctermfg=10
set termguicolors
let ayucolor='dark'
colorscheme ayu

noremap J <C-d>
noremap K <C-U>
nmap Y y$
map <Leader>i <Plug>(omnisharp_find_implementations)
map <Leader>d <Plug>(omnisharp_go_to_definitions)
map <Leader>f <Plug>(omnisharp_code_actions)
map <Leader>r <Plug>(omnisharp_find_usages)
map s <Plug>(easymotion-bd-f)
map S <Plug>(easymotion-overwin-f)
map <Leader>y :<C-U>call EasyUtil('normal! y')<CR>
map <Leader>Y :<C-U>call EasyUtil('normal! Y')<CR>
map <Leader>d :<C-U>call EasyUtil('normal! d')<CR>
map <Leader>D :<C-U>call EasyUtil('normal! D')<CR>
nmap <Leader>p <Plug>yankstack_substitute_older_paste
nmap <Leader>P <Plug>yankstack_substitute_newer_paste
command! EasyMotion call EasyMotion#S(1,0,2)
command! EasyMotionW call EasyMotion#OverwinF(1)
inoremap <silent><expr> <c-space> coc#refresh()

call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('buffer', 'date_format', '')
call denite#custom#var('session', 'path', '~/AppData/Local/nvim/sessions')
let s:denite_options = {
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }
call denite#custom#option('default', s:denite_options)

command! FileNavMode execute 'luafile' stdpath('config') . '/libmodal/file-nav.lua'

function! EasyUtil(c)
lua << EOF
    local api = vim.api
    api.nvim_set_var('doUtilAction', 0)
    local cursor = api.nvim_win_get_cursor(0)
    api.nvim_command('EasyMotion')
    local cursor2 = api.nvim_win_get_cursor(0)
    if not(cursor[1] == cursor2[1]) or not(cursor[2] == cursor2[2]) then
        api.nvim_win_set_cursor(0, cursor)
        api.nvim_command('normal! v')
        api.nvim_win_set_cursor(0, cursor2)
        api.nvim_set_var('doUtilAction', 1)
    end
EOF
if (g:doUtilAction)
    execute a:c
endif
endfunction

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>   denite#do_map('do_action')
    nnoremap <silent><buffer><expr> q      denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>  denite#do_map('quit')
    nnoremap <silent><buffer><expr> d      denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p      denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> i      denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <C-o>  denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <C-t>  denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> <C-v>  denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <C-h>  denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> <C-s>  denite#do_map('do_action', 'save')
endfunction
autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> l defx#do_action('open')
    nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P defx#do_action('preview')
    nnoremap <silent><buffer><expr> o defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns','mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d defx#do_action('remove')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
    nnoremap <silent><buffer><expr> w defx#do_action('change_vim_cwd')
endfunction

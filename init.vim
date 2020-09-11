call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'neomake/neomake'
Plug 'Iron-E/nvim-libmodal'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'rafi/vim-denite-session'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-dadbod'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
"Plug 'neoclide/coc-denite'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/vim-cursorword'
Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim'
Plug 'liuchengxu/vim-which-key'
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
set cindent
set updatetime=300
set whichwrap+=<,>,h,l,[,]
set switchbuf=useopen
set autoread
filetype plugin indent on
syntax enable

set hidden
let g:coc_global_extensions=['coc-omnisharp', 'coc-json', 'coc-html', 'coc-css', 'coc-sql', 'coc-tsserver', 'coc-prettier', 'coc-snippets', 'https://github.com/kuanyinglu/coc-symbol-lists']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:airline#extensions#coc#enabled = 1
let g:surround_no_mappings=1
let g:fugitive_no_maps = 1
let g:fruzzy#usenative = 1
let g:yankstack_yank_keys = ['y', 'Y']
let g:which_key_use_floating_win = 1
let g:which_key_hspace = 1
let g:tcomment_maps = 0
let g:clap_builtin_preload_capacity = 1000
let g:clap_disable_run_rooter = 1

hi EasyMotionTargetDefault ctermfg=10
set termguicolors
let ayucolor='dark'
colorscheme ayu

noremap J <C-d>
noremap K <C-U>
noremap H zH
noremap L zL
nmap Y y$
nmap s <Plug>(easymotion-bd-f)
nmap S <Plug>(easymotion-overwin-f)
nmap <leader>ey :<C-U>call EasyUtil('normal! y')<CR>
nmap <leader>eY :<C-U>call EasyUtil('normal! Y')<CR>
nmap <leader>ed :<C-U>call EasyUtil('normal! "_d')<CR>
nmap <leader>eD :<C-U>call EasyUtil('normal! "_D')<CR>
nmap <leader>ep <Plug>yankstack_substitute_older_paste
nmap <leader>eP <Plug>yankstack_substitute_newer_paste
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent><leader>cd <Plug>(coc-definition)
nmap <silent><leader>cy <Plug>(coc-type-definition)
nmap <silent><leader>ci <Plug>(coc-implementation)
nmap <silent><leader>cr <Plug>(coc-references)

""""""""""""""""""""Detect file changes""""""""""""""""""""""""
augroup AutoSwap
        autocmd!
        autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
        " if swapfile is older than file itself, just get rid of it
        if getftime(v:swapname) < getftime(a:filename)
                call delete(v:swapname)
                let v:swapchoice = 'e'
        endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END

""""""""""""""""""""COC configs""""""""""""""""""""""""""""""""
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
   \ pumvisible() ? "\<C-n>" :
   \ <SID>check_back_space() ? "\<TAB>" :
   \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"""""""""""""""""""Custom yank, delete motions""""""""""""""""""""""""
command! EasyMotion call EasyMotion#S(1,0,2)
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

"""""""""""""""""""Defx mapping""""""""""""""""""""""""""""""""""""""""
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>defx#do_action('open')
    nnoremap <silent><buffer><expr> <leader>fo  defx#do_action('open')
    nnoremap <silent><buffer><expr> <leader>fc  defx#do_action('copy')
    nnoremap <silent><buffer><expr> <leader>fm  defx#do_action('move')
    nnoremap <silent><buffer><expr> <leader>fp  defx#do_action('paste')
    nnoremap <silent><buffer><expr> <leader>fE  defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> <leader>fP  defx#do_action('preview')
    nnoremap <silent><buffer><expr> <leader>ft  defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> <leader>fK  defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> <leader>fN  defx#do_action('new_file')
    nnoremap <silent><buffer><expr> <leader>fM  defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> <leader>fC  defx#do_action('toggle_columns','mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> <leader>fS  defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> <leader>fd  defx#do_action('remove')
    nnoremap <silent><buffer><expr> <leader>fr  defx#do_action('rename')
    nnoremap <silent><buffer><expr> <leader>f!  defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> <leader>fx  defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> <leader>fy  defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> <leader>f.  defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <leader>f;  defx#do_action('repeat')
    nnoremap <silent><buffer><expr> <leader>fh  defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> <leader>f~  defx#do_action('cd')
    nnoremap <silent><buffer><expr> <leader>fq  defx#do_action('quit')
    nnoremap <silent><buffer><expr> <leader>fs  defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <leader>f*  defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> <leader>fj  line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> <leader>fk  line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <leader>ff  defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <leader>fl  defx#do_action('print')
    nnoremap <silent><buffer><expr> <leader>fw  defx#do_action('change_vim_cwd')
endfunction

"""""""""""""""""Custom Vim Clap extensions"""""""""""""""""""""""""
let g:clap_provider_quick_open = {
            \ 'source': ['~/AppData/Local/nvim/init.vim'],
            \ 'sink' : 'e',
            \ }
function! ParseQuickTask(str)
    let list = split(a:str, '%s')
    let command = ""
    for str in list
        let command = command.str
        if index(list, str) < len(list) - 1
            let command = command.input(">")
        endif
    endfor
    return eval(command)
endfunction
let g:clap_provider_quick_fix_tasks = {
            \ 'source': ["'s/%s/%s/ | update'"],
            \ 'sink' : {selected -> execute("cdo ".ParseQuickTask(selected))},
            \ }
"""""""""""""""""""Clap shortcuts""""""""""""""""""""""""""""""""""""""
nmap <leader>lf :<C-U>Clap files<CR>
nmap <leader>lg :<C-U>Clap grep<CR>
nmap <leader>lb :<C-U>Clap buffers<CR>
nmap <leader>lo :<C-U>Clap quick_open<CR>
nmap <leader>lq :<C-U>Clap quick_fix_tasks<CR>

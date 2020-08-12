call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'neomake/neomake'
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
filetype plugin indent on
syntax enable
hi CursorLine ctermbg=236
hi CursorColumn ctermbg=236

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

hi EasyMotionTargetDefault ctermfg=10
set termguicolors
let ayucolor='dark'
colorscheme ayu

noremap J <C-d>
noremap K <C-U>
nmap Y y$
nmap s <Plug>(easymotion-bd-f)
nmap S <Plug>(easymotion-overwin-f)
nmap <leader>ey :<C-U>call EasyUtil('normal! y')<CR>
nmap <leader>eY :<C-U>call EasyUtil('normal! Y')<CR>
nmap <leader>ed :<C-U>call EasyUtil('normal! d')<CR>
nmap <leader>eD :<C-U>call EasyUtil('normal! D')<CR>
nmap <leader>ep <Plug>yankstack_substitute_older_paste
nmap <leader>eP <Plug>yankstack_substitute_newer_paste
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
command! EasyMotion call EasyMotion#S(1,0,2)

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
\ 'split': 'floating',
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'winheight': 40,
\ 'vertical_preview': 1
\ }
call denite#custom#option('default', s:denite_options)

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

"Special function for doing action after each file is opened, so that find and
"replace etc can happen
function! s:file_do(context)
    call inputsave()
    let prompt = input('Run command: ', '', 'customlist,GetUsefulCommands')
    call inputrestore()
    for target in a:context['targets']
        let path = target['action__path']
        call denite#do_action(a:context, 'open', [target])
        if len(prompt) > 0
            execute prompt
        endif
    endfor
endfunction
call denite#custom#action('file', 'do', function('s:file_do'))

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>        denite#do_map('do_action')
    nnoremap <silent><buffer><expr> <leader><CR>denite#do_map('do_action')
    nnoremap <silent><buffer><expr> <leader>dq  denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>       denite#do_map('quit')
    nnoremap <silent><buffer><expr> <leader>dd  denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> <leader>dp  denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> <leader>di  denite#do_map('open_filter_buffer')
"    nnoremap <silent><buffer><expr> <leader>dt  denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> <leader>dv  denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <leader>dh  denite#do_map('do_action', 'split')
"    nnoremap <silent><buffer><expr> <leader>ds  denite#do_map('do_action', 'save')
    nnoremap <silent><buffer><expr> <leader>dt  denite#do_map('toggle_select')
    nnoremap <silent><buffer><expr> <leader>da  denite#do_map('toggle_select_all')
    nnoremap <silent><buffer><expr> <leader>do  denite#do_map('do_action', 'do')
endfunction
autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>defx#do_action('open')
    nnoremap <silent><buffer><expr> <leader><CR>defx#do_action('open')
    nnoremap <silent><buffer><expr> <leader>fc  defx#do_action('copy')
    nnoremap <silent><buffer><expr> <leader>fm  defx#do_action('move')
    nnoremap <silent><buffer><expr> <leader>fp  defx#do_action('paste')
    nnoremap <silent><buffer><expr> <leader>fl  defx#do_action('open')
    nnoremap <silent><buffer><expr> <leader>fE  defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> <leader>fP  defx#do_action('preview')
    nnoremap <silent><buffer><expr> <leader>fo  defx#do_action('open_tree', 'toggle')
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
    nnoremap <silent><buffer><expr> <leader>fs defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <leader>f*  defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> <leader>fj  line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> <leader>fk  line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <leader>ff  defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <leader>fp  defx#do_action('print')
    nnoremap <silent><buffer><expr> <leader>fw  defx#do_action('change_vim_cwd')
endfunction

let g:fileCommands = { 'FindAndReplace' : "'normal! '.len('%s').'xi%s'" }
function! GetFileCommands(argHead, cmdLine, cursorPos)
    return map(keys(g:fileCommands), {key, val -> GetCommand(val) })
endfunction
function! RunCommands(name, str)
    execute eval(a:str)
endfunction
function! GetCommand(name)
    return "call RunUsefulCommands('".a:name."',".'"'.g:usefulCommands[a:name].'")'
endfunction

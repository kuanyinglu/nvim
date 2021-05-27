if exists('g:vscode')
    call plug#begin('~/AppData/Local/nvim/vscode/plugged')
    Plug 'kuanyinglu/vim-easymotion'
    Plug 'machakann/vim-highlightedyank'
    Plug 'wellle/targets.vim'
    call plug#end()
    "Basic
    set hidden
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
    set cindent
    set switchbuf=useopen
    set autoread
    set ignorecase
    set smartcase 
    filetype plugin indent on
    syntax enable
    set guifont=Fira\ Code\ Nerd\ Font
    "Mappings
    vmap J 15j
    nmap J 15j
    vmap K 15k
    nmap K 15k
    nmap H 30h
    vmap H 30h
    nmap L 30l
    vmap L 30l
    map u :call VSCodeNotify('undo')<CR>
    map U :call VSCodeNotify('redo')<CR>
    vnoremap y "*y
    nnoremap y "*y
    vnoremap Y "*Y
    nnoremap Y "*Y
    vnoremap p "*p
    nnoremap p "*p
    vnoremap P "*P
    nnoremap P "*P
    imap <C-h> <C-w>h
    imap <C-j> <C-w>j
    imap <C-k> <C-w>k
    imap <C-l> <C-w>l
    vnoremap < <gv
    vnoremap > >gv
    nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
    xnoremap <expr> <C-/> <SID>vscodeCommentary()
    nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'
    nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
    nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
    xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>
    xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
    "Easymotion"
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_use_smartsign_us = 1
    let g:EasyMotion_keys='asdfghjkl;'
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
    let g:EasyMotion_disable_two_key_combo = 1
    map zj <Plug>(easymotion-j)
    map zk <Plug>(easymotion-k)
    map zl <Plug>(easymotion-lineforward)
    map zh <Plug>(easymotion-linebackward)
    nmap s :<C-u>call EasyMotion#go({ "within_line": 1, "direction": 0, "visualmode": 0, "pattern": "[^a-zA-Z0-9\t ]"})<CR>
    vmap s :<C-u>call EasyMotion#go({ "within_line": 1, "direction": 0, "visualmode": 1, "pattern": "[^a-zA-Z0-9\t ]"})<CR>
    nmap S :<C-u>call EasyMotion#go({ "within_line": 1, "direction": 1, "visualmode": 0, "pattern": "[^a-zA-Z0-9\t ]"})<CR>
    vmap S :<C-u>call EasyMotion#go({ "within_line": 1, "direction": 1, "visualmode": 1, "pattern": "[^a-zA-Z0-9\t ]"})<CR>
    nmap ; <Plug>(easymotion-next)
    vmap ; <Plug>(easymotion-next)
    nmap , <Plug>(easymotion-prev)
    vmap , <Plug>(easymotion-prev)
    nmap f <Plug>(easymotion-fl)
    vmap f <Plug>(easymotion-fl)
    nmap F <Plug>(easymotion-Fl)
    vmap F <Plug>(easymotion-Fl)
    nmap t <Plug>(easymotion-tl)
    vmap t <Plug>(easymotion-tl)
    nmap T <Plug>(easymotion-Tl)
    vmap T <Plug>(easymotion-Tl)
    "Targets
    autocmd User targets#mappings#user call targets#mappings#extend({
    \ '(': {'pair': [{'o': '(', 'c': ')'}]},
    \ ')': {'pair': [{'o': '(', 'c': ')'}]},
    \ '{': {'pair': [{'o': '{', 'c': '}'}]},
    \ '}': {'pair': [{'o': '{', 'c': '}'}]},
    \ '[': {'pair': [{'o': '[', 'c': ']'}]},
    \ ']': {'pair': [{'o': '[', 'c': ']'}]},
    \ '<': {'pair': [{'o': '<', 'c': '>'}]},
    \ '>': {'pair': [{'o': '<', 'c': '>'}]},
    \ '"': {'quote': [{'d': '"'}]},
    \ "'": {'quote': [{'d': "'"}]},
    \ '`': {'quote': [{'d': '`'}]},
    \ ',': {'separator': [{'d': ','}]},
    \ '.': {'separator': [{'d': '.'}]},
    \ ';': {'separator': [{'d': ';'}]},
    \ ':': {'separator': [{'d': ':'}]},
    \ '+': {'separator': [{'d': '+'}]},
    \ '-': {'separator': [{'d': '-'}]},
    \ '=': {'separator': [{'d': '='}]},
    \ '~': {'separator': [{'d': '~'}]},
    \ '_': {'separator': [{'d': '_'}]},
    \ '*': {'separator': [{'d': '*'}]},
    \ '#': {'separator': [{'d': '#'}]},
    \ '/': {'separator': [{'d': '/'}]},
    \ '\': {'separator': [{'d': '\'}]},
    \ '|': {'separator': [{'d': '|'}]},
    \ '&': {'separator': [{'d': '&'}]},
    \ '$': {'separator': [{'d': '$'}]},
    \ 't': {'tag': [{}]},
    \ 'a': {'argument': [{'o': '[([]', 'c': '[])]', 's': ','}]},
    \ 'b': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}]},
    \ 'q': {'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]},
    \ })
    "Custom functions
    function! s:split(...) abort
        let direction = a:1
        let file = a:2
        call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
        if file != ''
            call VSCodeExtensionNotify('open-file', expand(file), 'all')
        endif
    endfunction

    function! s:splitNew(...)
        let file = a:2
        call s:split(a:1, file == '' ? '__vscode_new__' : file)
    endfunction

    function! s:closeOtherEditors()
        call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
        call VSCodeNotify('workbench.action.closeOtherEditors')
    endfunction

    function! s:manageEditorSize(...)
        let count = a:1
        let to = a:2
        for i in range(1, count ? count : 1)
            call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
        endfor
    endfunction

    function! s:vscodeCommentary(...) abort
        if !a:0
            let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
            return 'g@'
        elseif a:0 > 1
            let [line1, line2] = [a:1, a:2]
        else
            let [line1, line2] = [line("'["), line("']")]
        endif

        call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
    endfunction

    function! s:openVSCodeCommandsInVisualMode()
        normal! gv
        let visualmode = visualmode()
        if visualmode == "V"
            let startLine = line("v")
            let endLine = line(".")
            call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
        else
            let startPos = getpos("v")
            let endPos = getpos(".")
            call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
        endif
    endfunction

    function! s:openWhichKeyInVisualMode()
        normal! gv
        let visualmode = visualmode()
        if visualmode == "V"
            let startLine = line("v")
            let endLine = line(".")
            call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
        else
            let startPos = getpos("v")
            let endPos = getpos(".")
            call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
        endif
    endfunction


    command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
    command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
    command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
    command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
    command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif
else
    call plug#begin('~/AppData/Local/nvim/plugged')
    Plug 'neomake/neomake'
    Plug 'machakann/vim-highlightedyank'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'Iron-E/nvim-libmodal'
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-fugitive'
    Plug 'bling/vim-airline'
    Plug 'tpope/vim-dadbod'
    Plug 'neoclide/coc.nvim',  {'branch': 'release'}
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
    set cindent
    set updatetime=300
    set whichwrap+=<,>,h,l,[,]
    set switchbuf=useopen
    set autoread
    filetype plugin indent on
    syntax enable

    set hidden
    let g:coc_global_extensions=['coc-omnisharp', 'coc-json', 'coc-html', 'coc-css', 'coc-sql', 'coc-tsserver', 'coc-prettier', 'coc-snippets']
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_smartcase = 1
    let g:airline#extensions#coc#enabled = 1
    let g:surround_no_mappings=1
    let g:fugitive_no_maps = 1
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
    nmap ; <Plug>(easymotion-next)
    vmap ; <Plug>(easymotion-next)
    nmap , <Plug>(easymotion-prev)
    vmap , <Plug>(easymotion-prev)
    nmap f <Plug>(easymotion-fl)
    vmap f <Plug>(easymotion-fl)
    nmap F <Plug>(easymotion-Fl)
    vmap F <Plug>(easymotion-Fl)
    nmap t <Plug>(easymotion-tl)
    vmap t <Plug>(easymotion-tl)
    nmap T <Plug>(easymotion-Tl)
    vmap T <Plug>(easymotion-Tl)
    nmap <leader>ey :<C-U>call EasyUtil('normal! y')<CR>
    nmap <leader>eY :<C-U>call EasyUtil('normal! Y')<CR>
    nmap <leader>ed :<C-U>call EasyUtil('normal! "_d')<CR>
    nmap <leader>eD :<C-U>call EasyUtil('normal! "_D')<CR>
    vnoremap y "*y
    nnoremap y "*y
    vnoremap Y "*Y
    nnoremap Y "*Y
    vnoremap p "*p
    nnoremap p "*p
    vnoremap P "*P
    nnoremap P "*P
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
    "command! EasyMotion call EasyMotion#S(1,0,2)
    "function! EasyUtil(c)
    "lua << EOF
    "    local api = vim.api
    "    api.nvim_set_var('doUtilAction', 0)
    "    local cursor = api.nvim_win_get_cursor(0)
    "    api.nvim_command('EasyMotion')
    "    local cursor2 = api.nvim_win_get_cursor(0)
    "    if not(cursor[1] == cursor2[1]) or not(cursor[2] == cursor2[2]) then
    "        api.nvim_win_set_cursor(0, cursor)
    "        api.nvim_command('normal! v')
    "        api.nvim_win_set_cursor(0, cursor2)
    "        api.nvim_set_var('doUtilAction', 1)
    "    end
    "EOF
    "if (g:doUtilAction)
    "    execute a:c
    "endif
    "endfunction

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
endif

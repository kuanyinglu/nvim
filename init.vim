if exists('g:vscode')    
    call plug#begin('~/AppData/Local/nvim/user/vscode/plugged')
    " Plug 'kuanyinglu/vim-easymotion'
    Plug 'kuanyinglu/vim-hop'
    Plug 'machakann/vim-highlightedyank'
    Plug 'wellle/targets.vim'
    Plug 'kuanyinglu/vim-momentum'
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
    " let g:EasyMotion_do_mapping = 0
    " let g:EasyMotion_smartcase = 1
    " let g:EasyMotion_use_smartsign_us = 1
    " let g:EasyMotion_keys='asdfghjkl;'
    " let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
    " let g:EasyMotion_disable_two_key_combo = 1
    nmap ss <Plug>(vim-momentum-start)
    xmap ss <Plug>(vim-momentum-vstart)
    nmap sh <Plug>(vim-hop-start)
    xmap sh <Plug>(vim-hop-vstart)
    " map sj <Plug>(easymotion-j)
    " map sk <Plug>(easymotion-k)
    " map sl <Plug>(easymotion-lineforward)
    " map sh <Plug>(easymotion-linebackward)
    " nmap ; <Plug>(easymotion-next)
    " vmap ; <Plug>(easymotion-next)
    " nmap , <Plug>(easymotion-prev)
    " vmap , <Plug>(easymotion-prev)
    " nmap f <Plug>(easymotion-fl)
    " vmap f <Plug>(easymotion-fl)
    " nmap F <Plug>(easymotion-Fl)
    " vmap F <Plug>(easymotion-Fl)
    " nmap t <Plug>(easymotion-tl)
    " vmap t <Plug>(easymotion-tl)
    " nmap T <Plug>(easymotion-Tl)
    " vmap T <Plug>(easymotion-Tl)
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
endif

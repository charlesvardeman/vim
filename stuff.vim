" T-Comment keymap
let g:tcommentMapLeader2 = '<leader>/'

let g:airline_powerline_fonts = 1 " Use airline fonts

" If you want to auto-completion to work stable in older vim, disable this option
let g:airline#extensions#tabline#enabled = 1

" Airline tabs settings
let g:airline#extensions#tabline#fnamemod = ':t'

let g:UltiSnipsJumpForwardTrigger='<tab>'

" Disabple showing function call signature
let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 0

" let's this deals vim-python-ftplugin module
let g:jedi#popup_on_dot = 0

" vim-python-ftplugin configuration
let g:python_docstring_in_foldtext = 1

" disable syntax checking
" because we use syntastic
let g:python_check_syntax=0

let g:python_syntax_fold=1
let g:python_fold_strings=1
let g:python_decorators_in_foldtext=1

let g:NERDTreeMinimalUI=1
let NERDTreeIgnore = ['\.pyc$']

" Make indent line faster
let g:indentLine_faster=1

" IndentLine character
" For use this feature please install patched font from repository root
let g:indentLine_char=nr2char(0xE0A3)

" Signify characters
let g:signify_sign_add=nr2char(0xE0B9)
let g:signify_sign_delete=nr2char(0xE0BA)
let g:signify_sign_delete_first_line=nr2char(0xE0BB)
let g:signify_sign_change=nr2char(0xE0BD)

" Signify colors
hi SignifySignAdd guibg=#4e4e4e ctermbg=NONE
hi SignifySignChange guibg=#4e4e4e ctermbg=NONE
hi SignifySignDelete guibg=#4e4e4e ctermbg=NONE
hi SignifySignChangeDelete guibg=#4e4e4e ctermbg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi FoldColumn ctermbg=NONE guibg=NONE
hi SyntasticError ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi SyntasticErrorSign ctermbg=NONE ctermfg=red guibg=NONE guifg=red
hi SyntasticWarningSign ctermbg=NONE ctermfg=red guibg=NONE guifg=green

" Required for vim-python-pep8-indent
let g:pymode_indent = 0

" Airline symbol for modified buffers
let g:airline_symbols={'modified': nr2char(0xE0B7)}

" Disable background and foreground for vertical split
hi vertsplit ctermbg=NONE guibg=NONE

" Syntax check mode for python (pip install pylama)
let g:syntastic_python_checkers = ['pylama']

" Syntax check mode for javascript (npm install jslint)
let g:syntastic_javascript_checkers = ['jslint']

" Make syntastic auto update the location list and make it also check
" when the file opens
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1

" Syntastic signs (disabled by default)
let g:syntastic_enable_signs=1

" Syntastic signs icons
let g:syntastic_error_symbol = nr2char(0xE0BB)
let g:syntastic_warning_symbol = nr2char(0xE0BE)

nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>s :CtrlPBufTag<cr>

" Comment selected line
map <leader>/ :TComment<CR>

" File autocomplte
imap <leader>f <c-x><c-f>

" Default autocomplete
imap <leader>c <c-x><c-o>

" Show/hide trail characters
nmap <leader>l :set list!<CR>

" Close buffer with ask save it
nnoremap <leader>w :confirm :Bclose<CR>


function! ToggleNERDTreeAndTagbar()
    let w:jumpbacktohere = 1

    " Detect which plugins are open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    " Perform the appropriate action
    if nerdtree_open && tagbar_open
        NERDTreeClose
        TagbarClose
    elseif nerdtree_open
        TagbarOpen
    elseif tagbar_open
        NERDTree
    else
        NERDTree
        TagbarOpen
    endif

    " Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor
endfunction
nnoremap <leader>e :call ToggleNERDTreeAndTagbar()<CR>

" The trailing '" {{{' is just to force folding on this function,
" since I `set foldmethod=marker` on `vim` file type.
function! FoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2)
    let fillcharcount = windowwidth - len(line)

    return line . repeat(" ", fillcharcount)
endfunction " }}}

set foldtext=FoldText()

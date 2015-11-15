" | FileType options | {{{
if has("autocmd")
  " Python indentation
  " About nosmartindent please look this link
  " http://stackoverflow.com/questions/2063175/vim-insert-mode-comments-go-to-start-of-line
  au FileType python setl nosmartindent

  " JavaScript indentation
  au FileType javascript setlocal expandtab shiftwidth=2 tabstop=2

  " Vim indentation
  au FileType vim setlocal expandtab shiftwidth=2 tabstop=2

  " Disable line numbers for QuickFix
  au FileType qf setlocal nonumber
endif
" }}}

" | statusline, buftabline | {{{
let g:buftabline_indicators=1

" Settings
"================================================================================
" Dynamically getting the fg/bg colors from the current colorscheme, returns hex which is enough for me to use in Neovim
" Needs to figure out how to return cterm values too
let fgcolor=synIDattr(synIDtrans(hlID("Normal")), "fg", "gui")
let bgcolor=synIDattr(synIDtrans(hlID("Normal")), "bg", "gui")

" Tabline/Buffer line
set showtabline=2
set tabline="%1T"
" reverse hybrid tabline colors
highlight TabLineFill cterm=none gui=none
highlight TabLine cterm=none gui=none
" This doesn't work, odd!
" highlight TabLineSel ctermfg=black ctermfg=white guibg=fgcolor guifg=bgcolor
highlight TabLineSel ctermfg=black ctermfg=white guibg=#c5c8c6 guifg=#1d1f21
highlight BufTabLineActive cterm=none gui=none

" Statusline
" https://github.com/Greduan/dotfiles/blob/76e16dd8a04501db29989824af512c453550591d/vim/after/plugin/statusline.vim

let g:currentmode={
      \ 'n'  : 'N ',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'V ',
      \ 'V'  : 'V·Line ',
      \ '' : 'V·Block ',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ '' : 'S·Block ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'Command ',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '
      \}


highlight User1 ctermfg=007 guifg=fgcolor
highlight User2 ctermfg=008 guifg=bgcolor
highlight User3 ctermfg=008 guifg=bgcolor
highlight User4 ctermfg=008 guifg=bgcolor
highlight User5 ctermfg=008 guifg=bgcolor
highlight User7 ctermfg=008 guifg=bgcolor
highlight User8 ctermfg=008 guifg=bgcolor
highlight User9 ctermfg=007 guifg=fgcolor

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008 guifg=fgcolor'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005 guifg=#00ff00'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004 guifg=#6CBCE8'
  else
    exe 'hi! StatusLine ctermfg=006 guifg=orange'
  endif

  return ''
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction
function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

set laststatus=2
set statusline=
"set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %{GitInfo()}                        " Git Branch name
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%0*\ %3p%%\ \ %l:\ %3c\                 " Rownumber/total (%)
" }}}

" | jedi-vim | {{{
let g:jedi#popup_on_dot = 1

let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#smart_auto_mappings = 0
" }}}

" | vim-togglecursor | {{{
let g:togglecursor_default="block"
let g:togglecursor_insert="line"
" }}}

" | ultisnips | {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" | indentLine | {{{
" Make indent line faster
let g:indentLine_faster=1
" IndentLine character
let g:indentLine_char=nr2char(0xA6)
" }}}

" | vim-htmldjango_omnicomplete | {{{
if has("autocmd")
  au FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
endif
" }}}

" | nerdtree | - | {{{
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeDirArrowExpandable = nr2char(0xE5FF)
let g:NERDTreeDirArrowCollapsible = nr2char(0xE5FE)

" Oh, I Love It! Taken from vim-vinegar
" but needed some refactoring
function! s:up_or_edit()
  if empty(expand('%'))
    execute 'silent edit .'
  else
    execute 'silent edit %:h/'
  endif
endfunction

nnoremap <silent> <Plug>Up :call <SID>up_or_edit()<CR>
if empty(maparg('-', 'n'))
  nmap - <Plug>Up
endif
nmap <buffer> - <Plug>Up
" }}}

" | vim-gitgutter | {{{
let g:gitgutter_max_signs=500
" }}}

" | :<tab> shows command list from fzf | {{{
set wildcharm=<Tab>
cnoremap <expr><tab> getcmdpos()>1?"\<Tab>":"Commands<CR>"
" }}}

" | Goto file with line number under cursor | gf | {{{
nnoremap gf gF
" }}}

" | Move visual block up or down | J, K | {{{
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" }}}

" | List toggle | <leader>l | {{{
nnoremap <silent> <Leader>l :set list!<CR>
" }}}

" | Close the current buffer and move to the previous one | <leader>w | {{{
nnoremap <silent> <leader>w :bp <BAR> bd #<CR>
" }}}

" | Quickly jump by declarations list | <leader>s |{{{
nnoremap <silent> <Leader>s :BTags<CR>
" }}}

" | Buffer list | <leader>b | {{{
nnoremap <silent> <Leader>b :Buffers<CR>
" }}}

" | Open files | <leader>f | {{{
nnoremap <silent> <Leader>f :Files<CR>
" }}}

" | Give directory for current file and open command mode | <leader>. | {{{
nnoremap <leader>. <Esc>: <C-R>=expand("%:p:h") . "/" <CR><Home>
" }}}

" | Switch between the last edited two files | <leader><leader> {{{
nnoremap <leader><leader> <c-^>
" }}}

" | Search word under cursor by using Ag | <leader>ag | {{{
noremap <silent><Leader>ag :Ag <C-R>=expand("<cword>")<CR><CR>
" }}}

" | Readline-style key bindings in command-line (excerpt from rsi.vim) | {{{
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"
" }}}

" | Color options | {{{
try
  set background=dark
  let base16colorspace=256
  colors base16-eighties
catch
endtry

" Disable background and foreground for vertical split
hi vertsplit ctermbg=NONE guibg=NONE
" }}}

" <tab> / <s-tab> / <c-v><tab> | super-duper-tab {{{
function! s:can_complete(func, prefix)
  if empty(a:func) || call(a:func, [1, '']) < 0
    return 0
  endif
  let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
  return !empty(type(result) == type([]) ? result : result.words)
endfunction

function! s:super_duper_tab(k, o)
  if pumvisible()
    return a:k
  endif

  let line = getline('.')
  let col = col('.') - 2
  if line[col] !~ '\k\|[/~.]'
    return a:o
  endif

  let prefix = expand(matchstr(line[0:col], '\S*$'))
  if prefix =~ '^[~/.]'
    return "\<c-x>\<c-f>"
  endif
  if s:can_complete(&omnifunc, prefix)
    return "\<c-x>\<c-o>"
  endif
  if s:can_complete(&completefunc, prefix)
    return "\<c-x>\<c-u>"
  endif
  return a:k
endfunction

if has_key(g:plugs, 'ultisnips')
  " UltiSnips will be loaded only when tab is first pressed in insert mode
  if !exists(':UltiSnipsEdit')
    inoremap <silent> <Plug>(tab) <c-r>=plug#load('ultisnips')?UltiSnips#ExpandSnippet():''<cr>
    imap <tab> <Plug>(tab)
  endif

  let g:SuperTabMappingForward  = "<s-tab>"
  let g:SuperTabMappingBackward = "<tab>"
  function! SuperTab(m)
    return s:super_duper_tab(a:m == 'n' ? "\<c-n>" : "\<c-p>",
                           \ a:m == 'n' ? "\<tab>" : "\<s-tab>")
  endfunction
else
  inoremap <expr> <tab>   <SID>super_duper_tab("\<c-n>", "\<tab>")
  inoremap <expr> <s-tab> <SID>super_duper_tab("\<c-p>", "\<s-tab>")
endif
" }}}

" vim:foldmethod=marker:foldlevel=0

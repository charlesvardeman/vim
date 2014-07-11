set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Work with code
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'tomtom/tcomment_vim'
Bundle 'mattn/emmet-vim'
Bundle 'terryma/vim-multiple-cursors'

" Git
Bundle 'mhinz/vim-signify'
Bundle 'tpope/vim-fugitive'

" Python
Bundle 'davidhalter/jedi-vim'

" Utils
Bundle 'aliev/bclose'
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'

" Color scheme
Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on     " required!

if has("gui_running")
    syntax on           " syntax-highlighting
    set background=dark " Backgroud
    colors solarized " Color scheme
    set guioptions=g " Disable all GUI elements
    set guioptions+=c " Enable Console-based dialogs for simple queries
    set hlsearch        " Highlight search terms (very useful!)
    set incsearch       " Show search matches while typing

    if has('mac')
        set guifont=Menlo\ Regular\ for\ Powerline:h12
    else
        set guifont=DejaVu\ Sans\ Mono\ 10
    endif
else
    syntax on
    set t_Co=256
    set background=dark
    colorscheme solarized
    if $TMUX == ''
        set clipboard+=unnamed

        " set the cursor to a vertical line in insert mode and a
        " solid block in command mode
        let &t_SI = "\<Esc>P\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>P\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else " if tmux

        " enable resize vim splits inside tmux
        set ttymouse=xterm2

        " set the cursor to a vertical line in insert mode and a
        " solid block in command mode
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    endif

    " don't blink the cursor
    set guicursor+=i:blinkwait0

    " Timeout for esc
    set timeout timeoutlen=1000 ttimeoutlen=10
endif


" Ebable colorcolumn
execute "set colorcolumn=" . join(range(81,335), ',')

if has('multi_byte')
    set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
endif

set fillchars=stl:\ ,stlnc:\ ,vert:│

if has("linebreak")
      let &sbr = nr2char(8618).' ' " Show ↪ at the beginning of wrapped lines
endif

set confirm " get a dialog when :q, :w, or :wq fails

let mapleader = "," " map leader

let maplocalleader = "_" " local leader

set lazyredraw " Don't redraw while executing macros (good performance config)

set laststatus=2 " enable statusline

set magic " For regular expressions turn magic on

set ignorecase " Searches are Non Case-sensitive

" set cursorline " Highlight current cursor position

" set cursorcolumn " Highlight cursor column

set smartcase " Do smart case matching when searching

set showmatch " Show matching brackets when text indicator is over them

set showcmd " Show incomplete cmds down the bottom

set showmode " Show current mode down the bottom

set title " show title

set acd " Vim will change the current working directory whenever you open a file

set expandtab " use space instead of tab

set autoread " Reload files changed outside automatically

set tabstop=4 " 1 tab == 4 spaces

set shiftwidth=4

set smarttab " Be smart when using tabs

set autoindent " Enable auto indent

set smartindent " Smart indent

set wrap " enable word wrap

" set nowrap " disable word wrap

set noerrorbells visualbell t_vb= " No annoying sound on errors

set encoding=utf8 " Default encoding

set termencoding=utf-8 " terminal encoding

set fileencodings=utf8,cp1251 " supported file encodings

set number " enable line numbers

set ruler " always display cursor position

if has('mouse')
    set mouse=a " Mouse support
    set mousemodel=popup
    set mousehide " Hide cursor when typing
endif

set hidden " A buffer becomes hidden when it is abandoned

set nobackup " Disable backup files

set noswapfile " Disable swap files

set noautochdir " change the current working directory whenever you open a file

set wildmenu " Turn on the Wild menu

set wildmode=list:longest,list:full " Wildmenu configuration

set wildignore+=*.o,*.pyc,*.jpg,*.png,*.gif,*.db,*.obj,.git " Ignore compiled files

set conceallevel=2 " Conceal level

set ttyfast " Optimize for fast terminal connections

set path=.,,**

" set iskeyword+=:

if has("autocmd")
    " Enable jedi completion for omnifunc
    au FileType python set omnifunc=jedi#completions

    " Disable jedi-vim documentation
    au FileType python setlocal completeopt-=preview

    " Indentation
    au FileType python setlocal expandtab shiftwidth=4 tabstop=8
    au FileType javascript setlocal expandtab shiftwidth=2 tabstop=8

    " Drawing λ for lambda
    au Syntax * syn keyword Operator lambda conceal cchar=λ
    " au Syntax * syn keyword Operator def conceal cchar=𝑓
    " au Syntax * syn keyword Operator : conceal cchar=→
    hi! link Conceal Operator
endif

" Comment selected line
map <leader>/ :TComment<CR>

" File autocomplte
imap <leader>f <c-x><c-f>

" Default autocomplete
imap <leader>c <c-x><c-o>

" Show/hide trail characters
nmap <leader>l :set list!<CR>

nnoremap <leader>e :NERDTreeToggle<CR>

" Close buffer with ask save it
nnoremap <leader>w :confirm :Bclose<CR>

" T-Comment keymap
let g:tcommentMapLeader2 = '<leader>/'

let g:airline_powerline_fonts = 1 " Use airline fonts

" If you want to auto-completion to work stable in older vim, disable this option
let g:airline#extensions#tabline#enabled = 1

" Airline tabs settings
let g:airline#extensions#tabline#fnamemod = ':t'

let g:UltiSnipsJumpForwardTrigger='<tab>'

let g:jedi#show_call_signatures = 0 " Disable or enable function call signature
let g:jedi#popup_on_dot = 0 " Disable autocomplete when i type dot
let g:jedi#use_tabs_not_buffers = 0

let g:NERDTreeMinimalUI=1
let NERDTreeIgnore = ['\.pyc$']

nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>


" {{{ colorscheme
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guioptions-=e
    "set guifont=Terminus\ 8
    set guifont=Monaco\ 7
    colorsche fnaqevan
    set mousehide
    "set guifont=iconsolata\ 8
    "colorsche bclear
    "colorscheme rdark
elseif (&term == 'xterm-color')
    set t_Co=256
    "colorscheme soso
    colorscheme asu1dark
else
    set background=dark
    colorscheme delek
endif
" }}}

" {{{ printer
set printdevice=LaserJet
"set printheader="%<%f%h%m%=Strona %N"
set printencoding=iso-8859-2
set printfont=curier
set printfont=Mono\ 8
" }}}

" {{{ main configuration
set mouse=a
"set spelllang=pl
"set spell
syntax on
set nocompatible
set nobackup
set ruler
set showcmd
set number
set hlsearch
set smarttab
set pastetoggle=<F11>
set autoindent
set wildmode=list:longest,full
set completeopt=longest,menuone
set enc=utf8
set textwidth=78
set fileencodings=utf-8
set foldmethod=marker
set foldlevelstart=0
"set path=$PWD/**
"set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
" }}}

" {{{ filetype configuration
filetype on
filetype plugin on
filetype indent on

autocmd BufNewFile * startinsert

autocmd BufReadPost        PKGBUILD         setfiletype PKGBUILD
autocmd BufRead,BufNewFile *.mkd            setfiletype mkd
autocmd BufRead,BufNewFile *.html           set textwidth=0
autocmd BufRead,BufNewFile *.html           set ft=htmldjango

autocmd BufRead,BufNewFile *.vala           setfiletype vala
autocmd BufRead,BufNewFile *.vapi           setfiletype vala

autocmd BufRead,BufNewFile *.js             setfiletype javascript.jquery
"}}}


" {{{ yankring plugin settings
let g:yankring_history_dir = expand("$HOME") . "/.yankring"
let g:yankring_min_element_length = 1
let g:yankring_max_history = 20
" }}}

" {{{ vim notes plugin http://www.vim.org/scripts/script.php?script_id=828
let g:VN_DefaultDir = "~/.vim_notes"
let g:VN_DefaultBrowser = "mozilla"
" }}}

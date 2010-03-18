" {{{ colorscheme
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guioptions-=e
    set guifont=Terminus\ 8
    "set guifont=Monaco\ 9
    "colorsche bclear
    set mousehide
    "set guifont=iconsolata\ 8
    "colorsche bclear
    colorscheme rdark
elseif (&term == 'xterm-color')
    set t_Co=256
    "colorscheme soso
    colorscheme mustang
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

" {{{ plugin settings
" calendar
let g:calendar_diary = "~/.calendar"
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

" }}}

" {{{ colorscheme
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guifont=Mono\ 10
    set mousehide
    colorsche eclm_wombat
elseif (&term == 'xterm-color')
    set t_Co=256
    set background=dark
    "colorscheme 256-grayvim
    color molokai
else
    set background=dark
    colorscheme delek
endif
" }}}

" {{{ main configuration
"set spelllang=pl
"set spell
syntax on
set nocompatible
set nobackup
set ruler
set showcmd
set number
set hlsearch
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set pastetoggle=<F11>
set autoindent
set wildmode=list:longest,full
set completeopt=longest,menuone
set enc=utf8
set textwidth=80
set fileencodings=utf-8,latin2
set foldmethod=marker
"set cursorline
" }}}

" {{{ filetype configuration
filetype on
filetype plugin on
filetype indent on

autocmd BufNewFile * startinsert

autocmd BufReadPost        PKGBUILD         setfiletype PKGBUILD
autocmd BufRead,BufNewFile *.mkd            setfiletype mkd
autocmd BufRead,BufNewFile *.html           set textwidth=0

autocmd BufRead,BufNewFile *.vala           setfiletype vala
autocmd BufRead,BufNewFile *.vapi           setfiletype vala
" }}}

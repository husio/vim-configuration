" {{{   gVim
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    "set guifont=Bitstream\ Vera\ Sans\ Mono\ 8
    set guifont=Monaco\ 10
    "set guifont=Terminus\ 9
    "set guifont=Dina\ 10
    set mousehide
    colorscheme native
endif 
" }}}

" {{{   console vim
if !has("gui_running")
    "colorscheme blueosx
    set background=dark
    colorscheme 256-candyblue
    colorscheme 256-grayvim
endif
" }}}

" {{{ for 256 color terminals
if (&term == 'xterm-color')
    "set t_Co=256
endif 

if (&term == 'linux')
    colorscheme desert
    set background=dark
endif
" }}}

" {{{ main configuration
"set spelllang=pl
"set spell
"syntax on	
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
"set completeopt=longest,menuone
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

autocmd BufReadPost PKGBUILD  set filetype=PKGBUILD
autocmd BufRead,BufNewFile *.mkd set filetype=mkd
" }}}

" {{{ vim wiki
let g:vimwiki_home = "~/.vimwiki/"
let g:vimwiki_syntax = "default"
let g:vimwiki_home_html = "~/vimwiki_html/"
" }}}

" {{{ pathogen init
call pathogen#runtime_append_all_bundles()
" }}}

" {{{ printing setup
set printdevice=LaserJet
"set printheader="%<%f%h%m%=Strona %N"
set printencoding=iso-8859-2
set printfont=curier
set printfont=Mono\ 8
" }}}

" {{{ main configuration
syntax on
set mouse=a
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
set tabstop=4
set shiftwidth=4
set expandtab
set nolazyredraw
set magic
" }}}


" {{{ custom vim mode settings (colorscheme, guioptions, etc)
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guioptions-=e
    set guifont=Terminus\ 8
    colorsche wombat
    set mousehide
elseif (&term == 'xterm-256color')
    set t_Co=256
    colorscheme 256-jungle
    colorscheme 256-graypurple
else
    set background=dark
    colorscheme ron
endif
" }}}


" {{{ line status builder
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/home/piotrek/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
" }}}

" {{{ filetype related configuration
filetype on
filetype plugin on
filetype indent on

autocmd BufNewFile * startinsert

autocmd BufReadPost        PKGBUILD         setfiletype PKGBUILD
autocmd BufRead,BufNewFile *.mkd            setfiletype mkd
autocmd BufRead,BufNewFile *.html           set textwidth=0
autocmd BufRead,BufNewFile *.html           set ft=htmldjango
autocmd BufRead,BufNewFile *.ejs            set ft=jst
autocmd BufRead,BufNewFile *.go             set ft=go


autocmd BufRead,BufNewFile *.js             setfiletype javascript.jquery
" remove white characters from end of each line
autocmd BufWritePre        *                :%s/\s\+$//e
"}}}


" {{{ yankring plugin setup
let g:yankring_history_dir = expand("$HOME") . "/.yankring"
" create yankring directory if does not exists
call system("[ -d " . g:yankring_history_dir . " ] || mkdir " . g:yankring_history_dir)
let g:yankring_min_element_length = 1
let g:yankring_max_history = 100
" }}}

"" {{{ main configuration
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
set fileencodings=utf-8
set foldmethod=marker
set foldlevelstart=0
set nolazyredraw
set magic
set laststatus=2
set timeoutlen=400
set tags+=.tags
set lazyredraw
set scrolljump=10
set background=dark
" }}}


" {{{ custom vim mode settings (colorscheme, guioptions, etc)
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guioptions-=e
    set guifont=Terminus\ 8
    colorscheme badwolf
    set mousehide
    let g:Powerline_symbols = 'fancy'
elseif (&term == 'xterm') || (&term == 'xterm-256color') || (&term == 'screen-256color')
    set t_Co=256
    "colorscheme badwolf
    "colorscheme monochrome
	colorscheme x
endif
" }}}


" {{{ filetype related configuration
filetype on
filetype plugin on
filetype indent on

autocmd BufNewFile         *                startinsert
autocmd BufWritePre        *                :%s/\s\+$//e
autocmd FileType go                         setl et! textwidth=0 colorcolumn=79
autocmd FileType python                     setl et! textwidth=79 colorcolumn=79 tabstop=4 shiftwidth=4 expandtab
autocmd FileType markdown                   setl et! textwidth=79 colorcolumn=79
autocmd BufNewFile,BufReadPost *.js         setl colorcolumn=79
autocmd FileType make                       setl noexpandtab
"}}}


" {{{ tab move
map      <C-t>      :tabnew<CR>
imap     <C-t>      :<Esc>tabnew<CR>i
map      <M-h>      :tabprev<CR>
imap     <M-h>      :<Esc>tabprev<CR>i
map      <M-l>      :tabnext<CR>
imap     <M-l>      :<Esc>tabnext<CR>i
" }}}


" {{{ window move
map      <C-j> <C-W>j
map      <C-k> <C-W>k
map      <C-h> <C-W>h
map      <C-l> <C-W>l
" }}}


" {{{ mouse keys
map      <S-Insert> <MiddleMouse>
map!     <S-Insert> <MiddleMouse>
imap     <S-Insert> <MiddleMouse>
" }}}


" {{{ syntastic
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='e!'
let g:syntastic_warning_symbol='w!'
let g:syntastic_go_checkers = ['go', 'govet']
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"
map      check        <Esc>:SyntasticCheck<CR>
" }}}


" {{{ yankring plugin setup
let g:yankring_history_dir = expand("$HOME") . "/.yankring"
" create yankring directory if does not exists
call system("[ -d " . g:yankring_history_dir . " ] || mkdir " . g:yankring_history_dir)
let g:yankring_min_element_length = 1
let g:yankring_max_history = 100
" }}}


" {{{ go
let g:go_highlight_extra_types = 0
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 0
" }}}


set shell=/bin/sh

call pathogen#infect()

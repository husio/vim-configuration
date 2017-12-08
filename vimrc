"" {{{ main configuration
syntax off
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
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
" }}}

colorscheme x

" {{{ gui
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guioptions-=e
    set guifont=terminus\ 8
    colorscheme desert
    set mousehide
endif
" }}}


" {{{ filetype related configuration
filetype on
filetype plugin on
filetype indent on

autocmd BufNewFile         *                startinsert
autocmd BufWritePre        *                :%s/\s\+$//e
autocmd FileType go                         setl textwidth=0 colorcolumn=79 noexpandtab
autocmd FileType python                     setl textwidth=79 colorcolumn=79 tabstop=4 shiftwidth=4 expandtab
autocmd FileType markdown                   setl colorcolumn=79 tabstop=2 shiftwidth=4 expandtab
autocmd FileType javascript                 setl colorcolumn=100 tabstop=2 shiftwidth=2 expandtab
autocmd FileType html,gohtmltmpl,htmldjango setl tabstop=2 shiftwidth=2 expandtab
autocmd FileType make                       setl noexpandtab
"}}}


" {{{ tab move
"map      <C-t>      :tabnew<CR>
"imap     <C-t>      :<Esc>tabnew<CR>i
"map      <M-h>      :tabprev<CR>
"imap     <M-h>      :<Esc>tabprev<CR>i
"map      <M-l>      :tabnext<CR>
"imap     <M-l>      :<Esc>tabnext<CR>i
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


" {{{ ale
let g:ale_sign_error = 'e'
let g:ale_sign_warning = 'w'
let g:ale_linters = {'go': ['go build', 'go vet']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_keep_list_window_open = 0
" }}}



" {{{ go
let g:go_highlight_extra_types = 0
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 0
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
" }}}


" {{{ elm
let g:elm_format_autosave = 1
" }}}

set shell=/bin/sh


call pathogen#infect()

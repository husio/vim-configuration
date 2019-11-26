" {{{ common
syntax off
set nobackup
set ruler
set showcmd
set nonumber
set hlsearch
set smarttab
set hidden
set pastetoggle=<F11>
set autoindent
set wildmode=list:longest,full
set completeopt=longest,menuone
set enc=utf8
set fileencodings=utf-8
set foldmethod=marker
set foldlevelstart=0
set laststatus=2
set timeoutlen=400
set tags+=.tags
set scrolljump=10
set background=dark
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
set cm=blowfish2
set shell=/bin/sh

colorscheme x
" }}}

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

augroup common
	autocmd!

	autocmd BufNewFile         *                startinsert
	autocmd BufWritePre        *                :%s/\s\+$//e

	autocmd FileType python                     setl textwidth=100 colorcolumn=79 tabstop=4 shiftwidth=4 expandtab
	autocmd FileType go                         setl colorcolumn=79 noexpandtab
	autocmd FileType markdown                   setl colorcolumn=79 tabstop=2 shiftwidth=4 expandtab spell spelllang=en_us
	autocmd FileType javascript                 setl colorcolumn=100 tabstop=2 shiftwidth=2 expandtab
	autocmd FileType html,gohtmltmpl,htmldjango setl tabstop=2 shiftwidth=2 expandtab
	autocmd FileType make                       setl noexpandtab
augroup end
"}}}

" {{{ window move
map      <C-j> <C-W>j
map      <C-k> <C-W>k
map      <C-h> <C-W>h
map      <C-l> <C-W>l
" }}}

" {{{ plugin: ale
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_linters = {'go': ['gopls']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_keep_list_window_open = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" disable highlight because we do not use syntax
let g:go_highlight_diagnostic_errors=0
let g:go_highlight_diagnostic_warnings=0
" }}}

" {{{ plugin: go
let g:go_highlight_extra_types = 0
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 0
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
" }}}

" {{{ plugin: elm
let g:elm_format_autosave = 1
" }}}

" {{{ plugin: python
let g:black_virtualenv = "~/.python_black"
" }}}

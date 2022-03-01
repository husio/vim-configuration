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
set background=dark
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
set cm=blowfish2
set shell=/bin/sh

colorscheme mono
" }}}

" {{{ filetype related configuration
filetype on
filetype plugin on
filetype indent on

augroup common
	autocmd!

	autocmd BufNewFile         *                startinsert

	autocmd FileType python                     setl textwidth=100 colorcolumn=79 tabstop=4 shiftwidth=4 expandtab
	autocmd FileType go                         setl colorcolumn=79 noexpandtab
	autocmd FileType markdown                   setl colorcolumn=79 tabstop=2 shiftwidth=4 expandtab spell spelllang=en_us
	autocmd FileType javascript                 setl colorcolumn=100 tabstop=2 shiftwidth=2 expandtab
	autocmd FileType html,gohtmltmpl,htmldjango setl tabstop=2 shiftwidth=2 expandtab
	autocmd FileType make                       setl noexpandtab
	autocmd FileType mail                       setl spell nonumber
augroup end
"}}}


" {{{ plugin: ale
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
"let g:ale_keep_list_window_open = 0
let g:ale_fixers = {
\ 	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'sh': ['shfmt'],
\       'python': ['black'],
\	}
let g:ale_linters = {'
\       go': ['gofmt', 'gopls', 'govet'],
\}
let g:ale_linters_ignore = ['golint']
let g:ale_fix_on_save = 1
let g:ale_sh_shfmt_options = '-i 2'
let g:ale_lint_delay = 500
" }}}


" {{{ plugin: go
let g:go_highlight_extra_types = 0
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 0
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" disable highlight because we do not use syntax
let g:go_highlight_diagnostic_errors=0
let g:go_highlight_diagnostic_warnings=0
" }}}

" {{{ plugin: elm
let g:elm_format_autosave = 1
" }}}

" {{{ plugin: rust
let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
" }}}

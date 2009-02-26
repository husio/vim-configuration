" Vim filetype plugin file
" Language:    Wiki
" Author:      Maxim Kim <habamax@gmail.com>
" Home:        http://code.google.com/p/vimwiki/
" Filenames:   *.wiki
" Last Change: 2009-02-18 10:27
" Version:     0.7.0

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1  " Don't load another plugin for this buffer


"" Defaults
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Reset the following options to undo this plugin.
let b:undo_ftplugin = "setl tw< wrap< lbr< sua< isf< awa< com< fo< fdt< fdm< fde< commentstring<"

setlocal textwidth=0
setlocal wrap
setlocal linebreak
setlocal autowriteall

" for gf
execute 'setlocal suffixesadd='.g:vimwiki_ext
setlocal isfname-=[,]

" for list items, and list items with checkboxes
setlocal comments=b:*\ [\ ],b:*[\ ],b:*\ [],b:*[],b:*\ [x],b:*[x]
setlocal comments+=b:#\ [\ ],b:#[\ ],b:#\ [],b:#[],b:#\ [x],b:#[x]
setlocal comments+=b:*,b:#
setlocal formatoptions=ctnqro

" folding for Headers using syntax fold method.
setlocal fdm=syntax

setlocal commentstring=<!--%s-->

"" commands {{{2
command! -buffer Vimwiki2HTML call vimwiki_html#Wiki2HTML(expand(g:vimwiki_home_html), expand('%'))
command! -buffer VimwikiAll2HTML call vimwiki_html#WikiAll2HTML(expand(g:vimwiki_home_html))

command! -buffer VimwikiNextWord call vimwiki#WikiNextWord()
command! -buffer VimwikiPrevWord call vimwiki#WikiPrevWord()
command! -buffer VimwikiDeleteWord call vimwiki#WikiDeleteWord()
command! -buffer VimwikiRenameWord call vimwiki#WikiRenameWord()
command! -buffer VimwikiFollowWord call vimwiki#WikiFollowWord('nosplit')
command! -buffer VimwikiGoBackWord call vimwiki#WikiGoBackWord()
command! -buffer VimwikiSplitWord call vimwiki#WikiFollowWord('split')
command! -buffer VimwikiVSplitWord call vimwiki#WikiFollowWord('vsplit')

command! -buffer VimwikiGTDToggleItem call vimwiki_gtd#GTDToggleItem()
"" commands 2}}}

"" keybindings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <buffer> <Up>   gk
nmap <buffer> k      gk
vmap <buffer> <Up>   gk
vmap <buffer> k      gk

nmap <buffer> <Down> gj
nmap <buffer> j      gj
vmap <buffer> <Down> gj
vmap <buffer> j      gj

imap <buffer> <Down>   <C-o>gj
imap <buffer> <Up>     <C-o>gk

nmap <silent><buffer> <CR> :VimwikiFollowWord<CR>
nmap <silent><buffer> <S-CR> :VimwikiSplitWord<CR>
nmap <silent><buffer> <C-CR> :VimwikiVSplitWord<CR>

nmap <buffer> <S-LeftMouse> <NOP>
nmap <buffer> <C-LeftMouse> <NOP>
noremap <silent><buffer> <2-LeftMouse> :VimwikiFollowWord<CR>
noremap <silent><buffer> <S-2-LeftMouse> <LeftMouse>:VimwikiSplitWord<CR>
noremap <silent><buffer> <C-2-LeftMouse> <LeftMouse>:VimwikiVSplitWord<CR>

nmap <silent><buffer> <BS> :VimwikiGoBackWord<CR>
"<BS> mapping doesn't work in vim console
nmap <silent><buffer> <C-h> :VimwikiGoBackWord<CR>
nmap <silent><buffer> <RightMouse><LeftMouse> :VimwikiGoBackWord<CR>

nmap <silent><buffer> <TAB> :VimwikiNextWord<CR>
nmap <silent><buffer> <S-TAB> :VimwikiPrevWord<CR>

nmap <silent><buffer> <Leader>wd :VimwikiDeleteWord<CR>
nmap <silent><buffer> <Leader>wr :VimwikiRenameWord<CR>

nmap <silent><buffer> <C-Space> :VimwikiGTDToggleItem<CR>

" keybindings }}}

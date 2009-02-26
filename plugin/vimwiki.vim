" VimWiki plugin file
" Language:    Wiki
" Author:      Maxim Kim (habamax at gmail dot com)
" Home:        http://code.google.com/p/vimwiki/
" Filenames:   *.wiki
" Last Change: 2009-02-18 10:02
" Version:     0.7.0

if exists("loaded_vimwiki") || &cp
  finish
endif
let loaded_vimwiki = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:default(varname,value)
  if !exists('g:vimwiki_'.a:varname)
    let g:vimwiki_{a:varname} = a:value
  endif
endfunction

"" Could be redefined by users
call s:default('home',"")
call s:default('index',"index")
call s:default('ext','.wiki')
call s:default('upper','A-ZА-Я')
call s:default('lower','a-zа-я')
call s:default('other','0-9_')
call s:default('maxhi','1')
call s:default('stripsym','_')
call s:default('syntax','default')
call s:default('gohome','split')
call s:default('home_html',g:vimwiki_home."html/")
call s:default('html_header',"")
call s:default('html_footer',"")

call s:default('history',[])

let g:vimwiki_home = expand(g:vimwiki_home)
let g:vimwiki_home_html = expand(g:vimwiki_home_html)
let g:vimwiki_html_header = expand(g:vimwiki_html_header)
let g:vimwiki_html_footer = expand(g:vimwiki_html_footer)

let upp = g:vimwiki_upper
let low = g:vimwiki_lower
let oth = g:vimwiki_other
let nup = low.oth
let nlo = upp.oth
let any = upp.nup

let g:vimwiki_word1 = '\C\<['.upp.']['.nlo.']*['.low.']['.nup.']*['.upp.']['.any.']*\>'
let g:vimwiki_word2 = '\[\[[^\]]\+\]\]'
let g:vimwiki_rxWikiWord = g:vimwiki_word1.'\|'.g:vimwiki_word2

execute 'autocmd! BufNewFile,BufReadPost,BufEnter *'.g:vimwiki_ext.' set ft=vimwiki'


command! VimwikiGoHome call vimwiki#WikiGoHome()
command! VimwikiTabGoHome tabedit <bar> call vimwiki#WikiGoHome()
command! VimwikiExploreHome execute "Explore ".g:vimwiki_home

if !hasmapto('<Plug>VimwikiGoHome')
  map <silent><unique> <Leader>ww <Plug>VimwikiGoHome
endif
noremap <unique><script> <Plug>VimwikiGoHome :VimwikiGoHome<CR>

if !hasmapto('<Plug>VimwikiTabGoHome')
  map <silent><unique> <Leader>wt <Plug>VimwikiTabGoHome
endif
noremap <unique><script> <Plug>VimwikiTabGoHome :VimwikiTabGoHome<CR>

if !hasmapto('<Plug>VimwikiExploreHome')
  map <silent><unique> <Leader>wh <Plug>VimwikiExploreHome
endif
noremap <unique><script> <Plug>VimwikiExploreHome :VimwikiExploreHome<CR>


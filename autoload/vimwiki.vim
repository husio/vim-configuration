" VimWiki plugin file
" Language:    Wiki
" Author:      Maxim Kim (habamax at gmail dot com)
" Home:        http://code.google.com/p/vimwiki/
" Filenames:   *.wiki
" Last Change: 2009-02-20 15:59
" Version:     0.6.3

if exists("g:loaded_vimwiki_auto") || &cp
  finish
endif
let g:loaded_vimwiki_auto = 1

let s:wiki_badsymbols = '[<>|?*/\:"]'

function! s:msg(message) "{{{
  echohl WarningMsg
  echomsg 'vimwiki: '.a:message
  echohl None
endfunction "}}}

function! s:get_file_name_only(filename) "{{{
  let word = substitute(a:filename, '\'.g:vimwiki_ext, "", "g")
  let word = substitute(word, '.*[/\\]', "", "g")
  return word
endfunction "}}}

function! s:editfile(command, filename) "{{{
  let fname = escape(a:filename, '% ')
  execute a:command.' '.fname
endfunction "}}}

function! s:SearchWord(wikiRx,cmd) "{{{
  let hl = &hls
  let lasts = @/
  let @/ = a:wikiRx
  set nohls
  try
    :silent exe 'normal ' a:cmd
  catch /Pattern not found/
    call s:msg('WikiWord not found')
  endt
  let @/ = lasts
  let &hls = hl
endfunction "}}}

function! s:WikiGetWordAtCursor(wikiRX) "{{{
  let col = col('.') - 1
  let line = getline('.')
  let ebeg = -1
  let cont = match(line, a:wikiRX, 0)
  while (ebeg >= 0 || (0 <= cont) && (cont <= col))
    let contn = matchend(line, a:wikiRX, cont)
    if (cont <= col) && (col < contn)
      let ebeg = match(line, a:wikiRX, cont)
      let elen = contn - ebeg
      break
    else
      let cont = match(line, a:wikiRX, contn)
    endif
  endwh
  if ebeg >= 0
    return strpart(line, ebeg, elen)
  else
    return ""
  endif
endf "}}}

function! s:WikiStripWord(word, sym) "{{{
  function! s:WikiStripWordHelper(word, sym)
    return substitute(a:word, s:wiki_badsymbols, a:sym, 'g')
  endfunction

  let result = a:word
  if strpart(a:word, 0, 2) == "[["
    " get rid of [[ and ]]
    let w = strpart(a:word, 2, strlen(a:word)-4)
    " we want "link" from [[link|link desc]]
    let w = split(w, "|")[0]
    let result = s:WikiStripWordHelper(w, a:sym)
  endif
  return result
endfunction "}}}

function! s:WikiIsLinkToNonWikiFile(word) "{{{
  " Check if word is link to a non-wiki file.
  " The easiest way is to check if it has extension like .txt or .html
  if a:word =~ '\.\w\{1,4}$'
    return 1
  endif
  return 0
endfunction "}}}

" WikiWord history helper functions {{{
" history is [['WikiWord.wiki', 11], ['AnotherWikiWord', 3] ... etc]
" where numbers are column positions we should return to when coming back.
function! s:GetHistoryWord(historyItem)
  return get(a:historyItem, 0)
endfunction
function! s:GetHistoryColumn(historyItem)
  return get(a:historyItem, 1)
endfunction
"}}}

function! vimwiki#WikiNextWord() "{{{
  call s:SearchWord(g:vimwiki_rxWikiWord, 'n')
endfunction "}}}

function! vimwiki#WikiPrevWord() "{{{
  call s:SearchWord(g:vimwiki_rxWikiWord, 'N')
endfunction "}}}

function! vimwiki#WikiFollowWord(split) "{{{
  if a:split == "split"
    let cmd = ":split "
  elseif a:split == "vsplit"
    let cmd = ":vsplit "
  else
    let cmd = ":e "
  endif
  let word = s:WikiStripWord(s:WikiGetWordAtCursor(g:vimwiki_rxWikiWord), g:vimwiki_stripsym)
  " insert doesn't work properly inside :if. Check :help :if.
  if word == ""
    execute "normal! \n"
    return
  endif
  if s:WikiIsLinkToNonWikiFile(word)
    call s:editfile(cmd, word)
  else
    call insert(g:vimwiki_history, [expand('%:p'), col('.')])
    call s:editfile(cmd, g:vimwiki_home.word.g:vimwiki_ext)
  endif
endfunction "}}}

function! vimwiki#WikiGoBackWord() "{{{
  if !empty(g:vimwiki_history)
    let word = remove(g:vimwiki_history, 0)
    " go back to saved WikiWord
    execute ":e ".substitute(s:GetHistoryWord(word),'\s','\\\0','g')
    call cursor(line('.'), s:GetHistoryColumn(word))
  endif
endfunction "}}}

function! vimwiki#WikiHighlightWords() "{{{
  let wikies = glob(g:vimwiki_home.'*')
  "" remove .wiki extensions
  let wikies = substitute(wikies, '\'.g:vimwiki_ext, "", "g")
  let g:vimwiki_wikiwords = split(wikies, '\n')
  "" remove paths
  call map(g:vimwiki_wikiwords, 'substitute(v:val, ''.*[/\\]'', "", "g")')
  "" remove backup files (.wiki~)
  call filter(g:vimwiki_wikiwords, 'v:val !~ ''.*\~$''')

  for word in g:vimwiki_wikiwords
    if word =~ g:vimwiki_word1 && !s:WikiIsLinkToNonWikiFile(word)
      execute 'syntax match wikiWord /\<'.word.'\>/'
      execute 'syntax match wikiWord /\[\[\<'.substitute(word,  g:vimwiki_stripsym, s:wiki_badsymbols, "g").'\>\(|\+.*\)*\]\]/'
    else
      execute 'syntax match wikiWord /\[\[\<'.substitute(word,  g:vimwiki_stripsym, s:wiki_badsymbols, "g").'\>\(|\+.*\)*\]\]/'
    endif
  endfor
  execute 'syntax match wikiWord /\[\[.\+\.\(jpg\|png\|gif\)\(|\+.*\)*\]\]/'
endfunction "}}}

function! vimwiki#WikiGoHome()"{{{
  try
    execute ':e '.g:vimwiki_home.g:vimwiki_index.g:vimwiki_ext
  catch /E37/ " catch 'No write since last change' error
    " this is really unsecure!!!
    execute ':'.g:vimwiki_gohome.' '.g:vimwiki_home.g:vimwiki_index.g:vimwiki_ext
  catch /E325/ " catch 'ATTENTION' error
    " TODO: Hmmm, if open already opened index.wiki there is an error...
    " Find out what is the reason and how to avoid it. Is it dangerous?
    echomsg "Unknown error!"
  endtry
  let g:vimwiki_history = []
endfunction"}}}

function! vimwiki#WikiDeleteWord() "{{{
  "" file system funcs
  "" Delete WikiWord you are in from filesystem
  let val = input('Delete ['.expand('%').'] (y/n)? ', "")
  if val!='y'
    return
  endif
  let fname = expand('%:p')
  " call WikiGoBackWord()
  try
    call delete(fname)
  catch /.*/
    call s:msg('Cannot delete "'.expand('%:r').'"!')
    return
  endtry
  execute "bdelete! ".escape(fname, " ")

  " delete from g:vimwiki_history list
  call filter (g:vimwiki_history, 's:GetHistoryWord(v:val) != fname')
  " as we got back to previous WikiWord - delete it from history - as much
  " as possible
  let hword = ""
  while !empty(g:vimwiki_history) && hword == s:GetHistoryWord(g:vimwiki_history[0])
    let hword = s:GetHistoryWord(remove(g:vimwiki_history, 0))
  endwhile

  " reread buffer => deleted WikiWord should appear as non-existent
  execute "e"
endfunction "}}}

function! vimwiki#WikiRenameWord() "{{{
  "" Rename WikiWord, update all links to renamed WikiWord
  let wwtorename = expand('%:r')
  let isOldWordComplex = 0
  if wwtorename !~ g:vimwiki_word1
    let wwtorename = substitute(wwtorename,  g:vimwiki_stripsym, s:wiki_badsymbols, "g")
    let isOldWordComplex = 1
  endif

  " there is no file (new one maybe)
  " if glob(g:vimwiki_home.expand('%')) == ''
  if glob(expand('%:p')) == ''
    call s:msg('Cannot rename "'.expand('%:p').'". It does not exist! (New file? Save it before renaming.)')
    return
  endif

  let val = input('Rename "'.expand('%:r').'" (y/n)? ', "")
  if val!='y'
    return
  endif
  let newWord = input('Enter new name: ', "")
  " check newWord - it should be 'good', not empty
  if substitute(newWord, '\s', '', 'g') == ''
    call s:msg('Cannot rename to an empty filename!')
    return
  endif
  if s:WikiIsLinkToNonWikiFile(newWord)
    call s:msg('Cannot rename to a filename with extension (ie .txt .html)!')
    return
  endif

  if newWord !~ g:vimwiki_word1
    " if newWord is 'complex wiki word' then add [[]]
    let newWord = '[['.newWord.']]'
  endif
  let newFileName = s:WikiStripWord(newWord, g:vimwiki_stripsym).g:vimwiki_ext

  " do not rename if word with such name exists
  let fname = glob(g:vimwiki_home.newFileName)
  if fname != ''
    call s:msg('Cannot rename to "'.newFileName.'". File with that name exist!')
    return
  endif
  " rename WikiWord file
  try
    echomsg "Renaming ".expand('%')." to ".g:vimwiki_home.newFileName
    let res = rename(expand('%'), g:vimwiki_home.newFileName)
    if res == 0
      bd
    else
      throw "Cannot rename!"
    end
  catch /.*/
    call s:msg('Cannot rename "'.expand('%:r').'" to "'.newFileName.'"')
    return
  endtry

  " save open buffers
  let openbuffers = []
  let bcount = 1
  while bcount<=bufnr("$")
    if bufexists(bcount)
      call add(openbuffers, bufname(bcount))
    endif
    let bcount = bcount + 1
  endwhile

  " update links
  echomsg "Updating links to ".newWord."..."
  execute ':silent args '.escape(g:vimwiki_home, " ").'*'.g:vimwiki_ext
  if isOldWordComplex
    execute ':silent argdo %sm/\[\['.wwtorename.'\]\]/'.newWord.'/geI | update'
  else
    execute ':silent argdo %sm/\<'.wwtorename.'\>/'.newWord.'/geI | update'
  endif
  execute ':silent argd *'.g:vimwiki_ext

  " restore open buffers
  let bcount = 1
  while bcount<=bufnr("$")
    if bufexists(bcount)
      if index(openbuffers, bufname(bcount)) == -1
        execute 'silent bdelete '.escape(bufname(bcount), " ")
      end
    endif
    let bcount = bcount + 1
  endwhile

  call s:editfile('e', g:vimwiki_home.newFileName)

  "" DONE: after renaming GUI caption is a bit corrupted?
  "" FIXED: buffers menu is also not in the "normal" state, howto Refresh menu?
  "" TODO: Localized version of Gvim gives error -- Refresh menu doesn't exist
  execute "silent! emenu Buffers.Refresh\ menu"

  echomsg wwtorename." is renamed to ".newWord
endfunction "}}}

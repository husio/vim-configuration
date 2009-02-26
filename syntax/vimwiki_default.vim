" Vim syntax file
" Language:    Wiki (vimwiki default)
" Author:      Maxim Kim (habamax at gmail dot com)
" Home:        http://code.google.com/p/vimwiki/
" Filenames:   *.wiki
" Last Change: 2009-02-19 10:16
" Version:     0.7.0

" text: *strong*
" let g:vimwiki_rxBold = '\*[^*]\+\*'
let g:vimwiki_rxBold = '\(^\|\s\+\|[[:punct:]]\)\zs\*[^*`]\+\*\ze\([[:punct:]]\|\s\+\|$\)'

" text: _emphasis_
" let g:vimwiki_rxItalic = '_[^_]\+_'
let g:vimwiki_rxItalic = '\(^\|\s\+\|[[:punct:]]\)\zs_[^_`]\+_\ze\([[:punct:]]\|\s\+\|$\)'

" text: *_strong italic_* or _*italic strong*_
let g:vimwiki_rxBoldItalic = '\(^\|\s\+\|[[:punct:]]\)\zs\(\*_[^*_`]\+_\*\)\|\(_\*[^*_`]\+\*_\)\ze\([[:punct:]]\|\s\+\|$\)'

" text: `code`
let g:vimwiki_rxCode = '`[^`]\+`'

" text: ~~deleted text~~
let g:vimwiki_rxDelText = '\~\~[^~`]\+\~\~'

" text: ^superscript^
let g:vimwiki_rxSuperScript = '\^[^^`]\+\^'

" text: ,,subscript,,
let g:vimwiki_rxSubScript = ',,[^,`]\+,,'

" Header levels, 1-6
let g:vimwiki_rxH1 = '^!\{1}.*$'
let g:vimwiki_rxH2 = '^!\{2}.*$'
let g:vimwiki_rxH3 = '^!\{3}.*$'
let g:vimwiki_rxH4 = '^!\{4}.*$'
let g:vimwiki_rxH5 = '^!\{5}.*$'
let g:vimwiki_rxH6 = '^!\{6}.*$'

" <hr>, horizontal rule
let g:vimwiki_rxHR = '^----.*$'

" Tables. Each line starts and ends with '||'; each cell is separated by '||'
let g:vimwiki_rxTable = '||'

" List items start with whitespace(s) then '*' or '#'
let g:vimwiki_rxListBullet = '^\s\+\*'
let g:vimwiki_rxListNumber = '^\s\+#'

" Treat all other lines that start with spaces as PRE-formatted text.
let g:vimwiki_rxPre1 = '^\s\+[^[:blank:]*#].*$'

" Preformatted text
let g:vimwiki_rxPreStart = '{{{'
let g:vimwiki_rxPreEnd = '}}}'

" Header's folding
let g:vimwiki_rxFoldH1Start = '^![^!]\+.*'
let g:vimwiki_rxFoldH1End = '^![^!]\+.*'

let g:vimwiki_rxFoldH2Start = '^!![^!]\+.*'
let g:vimwiki_rxFoldH2End = '^!!\{,1}[^!]\+.*'

let g:vimwiki_rxFoldH3Start = '^!!![^!]\+.*'
let g:vimwiki_rxFoldH3End = '^!!\{,2}[^!]\+.*'

let g:vimwiki_rxFoldH4Start = '^!!!![^!]\+.*'
let g:vimwiki_rxFoldH4End = '^!!\{,3}[^!]\+.*'

let g:vimwiki_rxFoldH5Start = '^!!!!![^!]\+.*'
let g:vimwiki_rxFoldH5End = '^!!\{,4}[^!]\+.*'

let g:vimwiki_rxFoldH6Start = '^!!!!!![^!]\+.*'
let g:vimwiki_rxFoldH6End = '^!!\{,5}[^!]\+.*'

" vim:tw=0:

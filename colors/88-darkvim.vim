" Vim color file
" Maintainer:	Piotr Husiatyński <phusiatynski@gmail.com>

set background=dark
set t_Co=88
let g:colors_name="88-darkvim"

let python_highlight_all = 1
let c_gnu = 1


hi Normal	    ctermfg=White       ctermbg=Black       cterm=None
hi Cursor       ctermfg=Gray        ctermbg=Green       cterm=None
hi SpecialKey	ctermfg=Green       ctermbg=Black       cterm=None
hi Directory	ctermfg=Green       ctermbg=Black       cterm=None
hi ErrorMsg     ctermfg=DarkRed     ctermbg=White       cterm=None
hi PreProc	    ctermfg=Red         ctermbg=Black       cterm=Bold
hi Search	    ctermfg=Black       ctermbg=Yellow      cterm=Bold
hi Type		    ctermfg=Blue        ctermbg=Black       cterm=Bold
hi Statement	ctermfg=Green       ctermbg=Black       cterm=Bold
hi Comment	    ctermfg=DarkGray    ctermbg=Black       cterm=Italic
hi LineNr	    ctermfg=DarkGray    ctermbg=Black       cterm=Bold
hi NonText	    ctermfg=Blue        ctermbg=Black       cterm=Bold
hi StatusLineNC ctermfg=Black       ctermbg=Blue        cterm=Bold
hi StatusLine   ctermfg=Black       ctermbg=Blue        cterm=None
hi VertSplit    ctermfg=Blue        ctermbg=Blue        cterm=Bold
hi DiffText	    ctermfg=Red         ctermbg=White       cterm=None
hi Constant	    ctermfg=Yellow      ctermbg=Black       cterm=Italic
hi Todo         ctermfg=Black       ctermbg=Yellow      cterm=Bold
hi Identifier	ctermfg=DarkBlue    ctermbg=Black       cterm=Bold
hi Error	    ctermfg=Black       ctermbg=Red         cterm=Bold
hi Special	    ctermfg=DarkRed     ctermbg=Black       cterm=Bold
hi FoldColumn	ctermfg=DarkGray    ctermbg=Black       cterm=Bold
hi Ignore       ctermfg=Yellow      ctermbg=Black       cterm=Bold
hi Underline    ctermfg=DarkGray    ctermbg=Black       cterm=Italic

hi Pmenu        ctermfg=White       ctermbg=DarkGray    cterm=None
hi PmenuSel     ctermfg=Black       ctermbg=Gray        cterm=Bold
hi PmenuSbar    ctermfg=DarkGray    ctermbg=DarkGray    cterm=None
hi PmenuThumb   ctermfg=Gray        ctermbg=Gray        cterm=None

"vim: sw=4

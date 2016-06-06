" Vim color file
" Maintainer:	Piotr Husiatyński <phusiatynski@gmail.com>

set background=dark
set t_Co=256
let g:colors_name="x"


hi Normal	    ctermfg=255         ctermbg=233        cterm=None
hi SpecialKey	ctermfg=87          ctermbg=None       cterm=Bold
hi Directory	ctermfg=76          ctermbg=None       cterm=None
hi ErrorMsg     ctermfg=124         ctermbg=233        cterm=None
hi PreProc	    ctermfg=246         ctermbg=None       cterm=Bold
hi Search	    ctermfg=233         ctermbg=46        cterm=Bold
hi Type		    ctermfg=246         ctermbg=None       cterm=Bold
hi Statement	ctermfg=246         ctermbg=None       cterm=None
hi Comment	    ctermfg=240         ctermbg=None       cterm=None
hi Identifier	ctermfg=111         ctermbg=None       cterm=Bold
hi DiffText	    ctermfg=88          ctermbg=250        cterm=None
hi Constant	    ctermfg=246         ctermbg=None       cterm=None
hi Todo         ctermfg=226         ctermbg=None       cterm=Bold
hi Error	    ctermfg=233         ctermbg=124        cterm=Bold
hi Special	    ctermfg=160         ctermbg=None       cterm=Bold
hi Ignore       ctermfg=220         ctermbg=None       cterm=Bold
hi Underline    ctermfg=244         ctermbg=None       cterm=None
hi ColorColumn  ctermfg=None        ctermbg=234        cterm=None
hi String       ctermfg=244         ctermbg=None       cterm=None

hi goFormatSpecifier ctermfg=248    ctermbg=None       cterm=None
hi goBoolean         ctermfg=246    ctermbg=None       cterm=None
hi goOperator        ctermfg=252    ctermbg=None       cterm=None
hi goConditional     ctermfg=248    ctermbg=None       cterm=None

hi FoldColumn	ctermfg=247         ctermbg=None       cterm=Bold
hi StatusLineNC ctermfg=247         ctermbg=234        cterm=None
hi StatusLine   ctermfg=247         ctermbg=233        cterm=Bold
hi VertSplit    ctermfg=247         ctermbg=234        cterm=Bold

hi LineNr	    ctermfg=238         ctermbg=None        cterm=Bold
hi NonText	    ctermfg=87          ctermbg=None        cterm=Bold


hi Pmenu        ctermfg=White       ctermbg=233        cterm=None
hi PmenuSel     ctermfg=None        ctermbg=233        cterm=Bold
hi PmenuSbar    ctermfg=DarkGray    ctermbg=233        cterm=None
hi PmenuThumb   ctermfg=Gray        ctermbg=233        cterm=None


"vim: sw=4

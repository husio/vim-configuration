" Vim color file
" Maintainer:  Piotr Husiatyński <phusiatynski@gmail.com>

set background=dark
let g:colors_name="mono"

if exists("syntax_on")
  syntax reset
endif

hi ColorColumn       ctermfg=None   ctermbg=233    cterm=None
hi Comment           ctermfg=None   ctermbg=None   cterm=None
hi Constant          ctermfg=None   ctermbg=None   cterm=None
hi DiffText          ctermfg=None   ctermbg=8      cterm=None
hi Directory         ctermfg=None   ctermbg=None   cterm=None
hi Error             ctermfg=1      ctermbg=None   cterm=None
hi ErrorMsg          ctermfg=1      ctermbg=None   cterm=None
hi FoldColumn        ctermfg=238    ctermbg=None   cterm=None
hi Identifier        ctermfg=None   ctermbg=None   cterm=None
hi Ignore            ctermfg=None   ctermbg=None   cterm=None
hi LineNr            ctermfg=238    ctermbg=None   cterm=None
hi NonText           ctermfg=238    ctermbg=None   cterm=None
hi Normal            ctermfg=15     ctermbg=None   cterm=None
hi Pmenu             ctermfg=7      ctermbg=8      cterm=None
hi PmenuSbar         ctermfg=1      ctermbg=None   cterm=None
hi PmenuSel          ctermfg=15     ctermbg=16     cterm=None
hi PmenuThumb        ctermfg=None   ctermbg=None   cterm=None
hi PreProc           ctermfg=None   ctermbg=None   cterm=None
hi Search            ctermfg=11     ctermbg=None   cterm=None
hi SignColumn        ctermfg=None   ctermbg=None   cterm=None
hi Special           ctermfg=None   ctermbg=None   cterm=None
hi SpecialKey        ctermfg=249    ctermbg=None   cterm=None
hi Statement         ctermfg=None   ctermbg=None   cterm=None
hi StatusLine        ctermfg=242    ctermbg=None   cterm=None
hi StatusLineNC      ctermfg=242    ctermbg=None   cterm=None
hi String            ctermfg=None   ctermbg=None   cterm=None
hi TabLine           ctermfg=238    ctermbg=None   cterm=None
hi TabLineFill       ctermfg=238    ctermbg=None   cterm=None
hi TabLineSel        ctermfg=15     ctermbg=None   cterm=None
hi Todo              ctermfg=13     ctermbg=None   cterm=None
hi Type              ctermfg=None   ctermbg=None   cterm=None
hi Underline         ctermfg=None   ctermbg=None   cterm=None
hi VertSplit         ctermfg=7      ctermbg=None   cterm=None

"vim: sw=4

" Vim color file
" Maintainer:  Piotr Husiatyński <phusiatynski@gmail.com>
"
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

set background=dark
set t_Co=256
let g:colors_name="x"

if exists("syntax_on")
  syntax reset
endif

hi ColorColumn       ctermfg=None   ctermbg=234    cterm=None
hi Comment           ctermfg=249    ctermbg=None   cterm=None
hi Constant          ctermfg=None   ctermbg=None   cterm=None
hi DiffText          ctermfg=88     ctermbg=250    cterm=None
hi Directory         ctermfg=None   ctermbg=None   cterm=None
hi Error             ctermfg=124    ctermbg=None   cterm=None
hi ErrorMsg          ctermfg=124    ctermbg=None   cterm=None
hi FoldColumn        ctermfg=238    ctermbg=None   cterm=None
hi Identifier        ctermfg=None   ctermbg=None   cterm=None
hi Ignore            ctermfg=None   ctermbg=None   cterm=None
hi LineNr            ctermfg=238    ctermbg=None   cterm=None
hi NonText           ctermfg=238    ctermbg=None   cterm=None
hi Normal            ctermfg=15     ctermbg=None   cterm=None
hi Pmenu             ctermfg=255    ctermbg=None   cterm=None
hi PmenuSbar         ctermfg=None   ctermbg=237    cterm=None
hi PmenuSel          ctermfg=None   ctermbg=15     cterm=None
hi PmenuThumb        ctermfg=None   ctermbg=237    cterm=None
hi PreProc           ctermfg=None   ctermbg=None   cterm=None
hi Search            ctermfg=190    ctermbg=None   cterm=None
hi SignColumn        ctermfg=None   ctermbg=None   cterm=None
hi Special           ctermfg=None   ctermbg=None   cterm=None
hi SpecialKey        ctermfg=249    ctermbg=None   cterm=None
hi Statement         ctermfg=None   ctermbg=None   cterm=None
hi StatusLine        ctermfg=242    ctermbg=None   cterm=None
hi StatusLineNC      ctermfg=242    ctermbg=None   cterm=None
hi String            ctermfg=None   ctermbg=None   cterm=None
hi TabLine           ctermfg=238    ctermbg=0      cterm=None
hi TabLineFill       ctermfg=238    ctermbg=0      cterm=None
hi TabLineSel        ctermfg=15     ctermbg=0      cterm=None
hi Todo              ctermfg=214    ctermbg=None   cterm=None
hi Type              ctermfg=None   ctermbg=None   cterm=None
hi Underline         ctermfg=None   ctermbg=None   cterm=None
hi VertSplit         ctermfg=238    ctermbg=None   cterm=None


"vim: sw=4

if exists("b:current_syntax")
    finish
endif

let s:vala_cpo_save = &cpo
set cpo&vim


" type
syn keyword valaType          bool byte char decimal double float
syn keyword valaType          int long object sbyte short string uint
syn keyword valaType          ulong ushort void
" storage
syn keyword valaStorage       class delegate enum interface namespace
syn keyword valaStorage       struct
" repeate / condition / label
syn keyword valaRepeat        break continue do for foreach goto
syn keyword valaRepeat        return while yield
syn keyword valaConditional   else if switch
syn keyword valaLabel         case default

" there's no :: operator in C#
syn match valaOperatorError   display +::+
" user labels (see [1] 8.6 Statements)
syn match   valaLabel         display +^\s*\I\i*\s*:\([^:]\)\@=+
" modifier
syn keyword valaModifier      abstract const extern internal override
syn keyword valaModifier      private protected public readonly sealed signal
syn keyword valaModifier      static virtual volatile partial
" constant
syn keyword valaConstant      false null true
" exception
syn keyword valaException     try catch finally throw

" TODO:
syn keyword valaUnspecifiedStatement  as base checked event fixed in is lock
syn keyword valaUnspecifiedStatement  new operator out params ref sizeof
syn keyword valaUnspecifiedStatement  stackalloc this typeof unchecked unsafe
syn keyword valaUnspecifiedStatement  using
" TODO:
syn keyword valaUnsupportedStatement  get set add remove value
" TODO:
syn keyword valaUnspecifiedKeyword    explicit implicit where

" Comments
"
" PROVIDES: @valaCommentHook
"
" TODO: include strings ?
"
syn region  valaComment       start="/\*"  end="\*/" contains=@valaCommentHook
syn match   valaComment       "//.*$" contains=@valaCommentHook

" xml markup inside '///' comments
syn cluster xmlRegionHook   add=valaXmlCommentLeader
syn cluster xmlCdataHook    add=valaXmlCommentLeader
syn cluster xmlStartTagHook add=valaXmlCommentLeader
syn keyword valaXmlTag        contained c code example exception include list
syn keyword valaXmlTag            contained para param paramref permission remarks
syn keyword valaXmlTag            contained returns see seealso summary value

syn cluster xmlTagHook add=valaXmlTag

syn match   valaXmlCommentLeader  +\/\/\/+    contained
syn match   valaXmlComment    +\/\/\/.*$+ contains=valaXmlCommentLeader,@valaXml
"syntax include @valaXml <sfile>:p:h/xml.vim
hi def link xmlRegion Comment


" [1] 9.5 Pre-processing directives
syn region  valaPreCondit
            \ start="^\s*#\s*\(define\|undef\|if\|elif\|else\|endif\|line\|error\|warning\|region\|endregion\)"
                \ skip="\\$" end="$" contains=valaComment keepend

" Strings and constants
syn match   valaSpecialError  contained "\\."
syn match   valaSpecialCharError  contained "[^']"
" [1] 9.4.4.4 Character literals
syn match   valaSpecialChar   contained +\\["\\'0abfnrtvx]+
" unicode characters
syn match   valaUnicodeNumber +\\\(u\x\{4}\|U\x\{8}\)+ contained contains=valaUnicodeSpecifier
syn match   valaUnicodeSpecifier  +\\[uU]+ contained
syn region  valaVerbatimString    start=+@"+ end=+"+ end=+$+ contains=valaVerbatimSpec
syn match   valaVerbatimSpec  +@"+he=s+1 contained
syn region  valaString        start=+"+  end=+"+ end=+$+ contains=valaSpecialChar,valaSpecialError,valaUnicodeNumber
syn match   valaCharacter     "'[^']*'" contains=valaSpecialChar,valaSpecialCharError
syn match   valaCharacter     "'\\''" contains=valaSpecialChar
syn match   valaCharacter     "'[^\\]'"
syn match   valaNumber        "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   valaNumber        "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   valaNumber        "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   valaNumber        "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" The default highlighting.
hi def link valaType                  Type
hi def link valaStorage               StorageClass
hi def link valaRepeat                Repeat
hi def link valaConditional           Conditional
hi def link valaLabel                 Label
hi def link valaModifier              StorageClass
hi def link valaConstant              Constant
hi def link valaException             Exception
hi def link valaUnspecifiedStatement  Statement
hi def link valaUnsupportedStatement  Statement
hi def link valaUnspecifiedKeyword    Keyword
hi def link valaOperatorError         Error

hi def link valaComment           Comment

hi def link valaSpecialError      Error
hi def link valaSpecialCharError  Error
hi def link valaString            String
hi def link valaVerbatimString    String
hi def link valaVerbatimSpec      SpecialChar
hi def link valaPreCondit         PreCondit
hi def link valaCharacter         Character
hi def link valaSpecialChar       SpecialChar
hi def link valaNumber            Number
hi def link valaUnicodeNumber     SpecialChar
hi def link valaUnicodeSpecifier  SpecialChar

" xml markup
hi def link valaXmlCommentLeader  Comment
hi def link valaXmlComment        Comment
hi def link valaXmlTag            Statement

let b:current_syntax = "vala"

let &cpo = s:vala_cpo_save
unlet s:vala_cpo_save

" vim: ts=4

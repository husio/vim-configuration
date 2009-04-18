" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1


set foldmethod=expr
"set foldcolumn=2
"set foldlevel=3
set foldexpr=2
set foldlevelstart=1
set foldnestmax=3
set foldminlines=10
set foldexpr=PythonFoldExpr(v:lnum)
set foldtext=PythonFoldText()


function! PythonFoldText()
    let size = 1 + v:foldend - v:foldstart
    if size < 10
        let size = " " . size
    endif
    if size < 100
        let size = " " . size
    endif
    if size < 1000
        let size = " " . size
    endif
    if match(getline(v:foldstart), '"""') >= 0
        let text = substitute(getline(v:foldstart), '"""', '', 'g' ) . ' '
    elseif match(getline(v:foldstart), "'''") >= 0
        let text = substitute(getline(v:foldstart), "'''", '', 'g' ) . ' '
    else
        let text = getline(v:foldstart)
    endif
    return size . ' lines:'. text . ' '
endfunction

function! PythonFoldExpr(lnum)
    if indent(nextnonblank(a:lnum)) == 0
        return 0
    endif
    if indent(a:lnum) == 0
        return 0
    endif
    if getline(a:lnum) =~ '^\s*$'
        return "="
    endif
    "if getline(a:lnum-1) =~ '^\(class\|def\)\s'
    "    return 1
    "endif
    if getline(a:lnum-1) =~ '^\s\{4\}\(class\|def\)\s'
        return 1
    endif
    return '='
endfunction

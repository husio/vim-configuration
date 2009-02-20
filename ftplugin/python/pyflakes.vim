function! Pyflakes()
    " temporary change compiler
    let l:last_compiler = b:current_compiler
    compiler pyflakes
    make
    redraw
    try 
        cc
    catch E42
        echo "Pyflakes check: ok"
    endtry
    exec "compiler ". l:last_compiler
endfunction

autocmd BufWritePost        *.py    call Pyflakes()

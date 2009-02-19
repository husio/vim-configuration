function! Pyflakes()
    make
    redraw
    try 
        cc
    catch E42
        echo "Pyflakes check: ok"
    endtry
endfunction

compiler pyflakes
autocmd BufWritePost        *.py    call Pyflakes()

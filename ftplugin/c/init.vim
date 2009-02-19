function! InsertIfDef() 
    let filename = "__" . substitute(toupper(expand("%:t")), "\\.", "_", "g") . "__"
    normal mi 
    normal gg
    execute "normal! i#ifndef " . filename . "\n"
    execute "normal! i#define " . filename . "\n\n\n"
    execute "normal! GA\n\n#endif /*      #ifndef " . filename . "     */" 
    normal 'i
endfunction
map <leader>ifdef        :call InsertIfDef()<CR>


function! InsertMain()
    normal G
    execute "normal! iint main(int argc, char *argv[])\n{\n\nreturn EXIT_SUCCESS;\n}"
    execute "normal! kk$i    "
endfunction
map <leader>init        :call InsertMain()<CR>


function! RunGDB()
    let l:terminal = "xterm"
    execute "!". l:terminal ." -e  gdb ". input("Application name: ") . "&"
    normal <Esc>
endfunction
map <leader>gdb        :call RunGDB()<CR>

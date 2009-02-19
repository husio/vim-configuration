if exists("b:loaded_py_gtk_doc_plugin")
  finish
endif
let b:loaded_py_gtk_doc_plugin = 1

let b:buff_name = "__pygtk_doc__"


function! ShowPyGtkDoc(name)
    if !exists("g:pydoc_cmd")
        let g:pydoc_cmd = "pydoc"
    endif
    if !bufnr(b:buff_name)
        exec "sb " . b:buff_name
    else
        exec "vsplit " . b:buff_name
    endif
    setlocal noswapfile
    set buftype=nofile
    setlocal modifiable
    normal ggdG

    execute "silent read ! ". g:pydoc_cmd . " gtk." . a:name 
    setlocal nomodified
    set filetype=man
    normal G
    
endfunction

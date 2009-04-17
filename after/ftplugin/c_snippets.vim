if !exists('loaded_snippet') || &cp
    finish
endif

function! IfDefInsert()
    let current_line = line('.')
    let modname = expand("%:t:r")
    normal gg
    exec "normal O\n#ifndef __". modname ."__\n#define __". modname ."__"
    normal G
    exec "normal o#endif /* __". modname ."__ */"
    exec "normal ". current_line ."gg"
    return ""
endfunction


let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet ifdef ``IfDefInsert()``"

exec "Snippet class typedef struct _".st."classname".et." ".st."classname".et.";<CR><CR>struct _".st."classname".et." {<CR><CR>};<CR>".st.et

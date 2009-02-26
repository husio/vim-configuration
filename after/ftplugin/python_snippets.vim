if !exists('loaded_snippet') || &cp
    finish
endif


let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

function! Shebang()
    if line(".") == 1
        return "#!/usr/bin/env python\n# -*- coding: UTF-8 -*-\n\n"
    else
        return "py"
    endif
endfunction





" From Panos
exec "Snippet ifname if __name__ == \"__main__\":<CR>".st.et
exec "Snippet ifmain if __name__ == \"__main__\":<CR>".st.et

" Shebang
exec "Snippet py ``Shebang()``".st.et

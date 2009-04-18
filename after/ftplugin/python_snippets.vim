if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim


function ShebangInsert()
    if line('.') is 1
        return "#!/usr/bin/env python\n# -*- coding: UTF-8 -*-\n\n"
    endif
    return "py"
endfunction


exec 'Snippet ifname if __name__ == "__main__":<CR>'.st.et

exec 'Snippet py ``ShebangInsert()``'.st.et
exec 'Snippet pye # -*- coding: UTF-8 -*-<CR>'.st.et

exec 'Snippet rev __revision__ = "$Id$"<CR>'.st.et

exec 'Snippet trace import ipdb; ipdb.set_trace()<CR>'.st.et

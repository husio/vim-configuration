function DateTag()
    return strftime("%d.%m.%y at %H:%M")
endfunction

function FormatInfo()
    return "filetype=" . &filetype . 
                \ ":expandtab" .
                \":shiftwidth=". &shiftwidth .
                \":tabstop=". &tabstop .
                \":softtabstop=" . &softtabstop .
                \":encoding=" . &encoding .
                \":textwidth=". &textwidth
endfunction


let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet VIMINFO vim:``FormatInfo()``".st.et
exec "Snippet DATE ``DateTag()``<CR>".st.et
exec "Snippet TODO TODO ``DateTag()``<CR>".st.et


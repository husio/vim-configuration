function! InitInsert()
    normal migg
    exec "normal i#!/usr/bin/env python\n".
         \"# -*- coding: utf-8 -*-\n\n"
    normal 'i
    startinsert
endfunction

map <leader>init    :call InitInsert()<CR>

compiler python

let python_highlight_all = 1
imap #enc   # -*- coding: utf-8 -*-

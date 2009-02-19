if exists("b:__magic_load_ftplugin")
    finish
endif
let b:__magic_load_ftplugin = 1

let b:filetype_pluglist = "ftplugin/". expand("%", ":t:r") ."/*"

" load each plugin from filetype plugin directory
for plugfile in split(globpath(&rtp, b:filetype_pluglist), "\n")
    exec "silent! source ". plugfile
endfor

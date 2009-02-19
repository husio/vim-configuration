" insert JavaScript include
iab _js <script type="text/javascript" src="%"></script><Esc>F%s<C-o>:call getchar()<CR>

" insert CSS include
iab _css <link rel="stylesheet" type="text/css" href="%" /><Esc>F%s<C-o>:call getchar()<CR>

" init
function! InitHTML()
    execute 'normal! i<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">'
            \. "\n<html xmlns=\"http://www.w3.org/1999/xhtml\">"
            \. "\n<head>"
            \. "\n<title>Bla!</title>"
            \. "\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />"
            \. "\n</head>"
            \. "\n<body>"
            \. "\n"
            \. "\n</body>"
            \. "\n</html>"
endfunction
map <leader>init        :call InitHTML()<CR>

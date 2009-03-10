" from: http://taeril.jogger.pl/2008/11/23/vim-przeglad-schematow-kolorow/
fun! ShowColorsList()
    if bufexists(bufnr("__COLORS__"))
        exec ':' . bufnr("__COLORS__") . 'bwipeout'
        return
    endif

    let l:width = 16

    exec 'silent! ' . l:width . 'vne __COLORS__'
    setl noshowcmd
    setl noswapfile
    setl buftype=nofile
    setl bufhidden=delete
    setl nobuflisted
    setl nowrap
    setl nonumber
    setl nospell
    setl foldcolumn=0

    setl cursorline

    setl modifiable
    for ks in split(globpath(&rtp, "colors/*.vim"), '\n')
        let ks = fnamemodify(ks, ':t:r')
        call append(line('$'), ks)
    endfor
    
    sort iu
    norm gg"_dd
    setl nomodifiable
    setl noinsertmode

    noremap <silent> <buffer> <CR> :exec 'colo '.substitute(getline(line('.')), '\s.*$', '', '')<CR>
    map <silent> <buffer> q :bwipeout<CR> 
    map <buffer> i <Nop>
    map <buffer> a <Nop>
    map <buffer> I <Nop>
    map <buffer> A <Nop>
    map <buffer> o <Nop>
    map <buffer> O <Nop>
endfun


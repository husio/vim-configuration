" from: http://taeril.jogger.pl/2008/11/23/vim-przeglad-schematow-kolorow/

let s:buff_name = "colorschame_chooser"
let s:buff_width = 22


function! ColorschemeChooserClose()
    exec ':' . bufnr(s:buff_name) . 'bwipeout'
endfunction

function! ColorschemeChooserSetSelected()
    exec 'colorscheme '. substitute(getline(line('.')), '\s.*$', '', '')
endfunction

function! ColorschemeChooserOpen()
    exec 'silent! ' . s:buff_width . ' vne '. s:buff_name
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

    for scheme_file in split(globpath(&rtp, "colors/*.vim"), '\n')
        let l:scheme_name = fnamemodify(scheme_file, ':t:r')
        call append(line('$'), l:scheme_name)
    endfor
    
    sort iu
    norm gg"_dd
    setl nomodifiable
    setl noinsertmode

    noremap <silent> <buffer> <CR>  :call ColorschemeChooserSetSelected()<CR>
    map <silent> <buffer> q         :call ColorschemeChooserClose()<CR> 
    map <buffer> i <Nop>
    map <buffer> a <Nop>
    map <buffer> I <Nop>
    map <buffer> A <Nop>
    map <buffer> o <Nop>
    map <buffer> O <Nop>

    syntax match Underline /.*\%#.*/
    autocmd  BufLeave <buffer>     exec ':' . bufnr(s:buff_name) . ' bwipeout'
endfunction


function! ColorschemeChooserToggle()
    if bufexists(bufnr(s:buff_name))
        call ColorschemeChooserClose()
    else
        call ColorschemeChooserOpen()
    endif
endfunction

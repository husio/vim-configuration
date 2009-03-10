let s:sessions_data_path = "~/.vim_sessions/"
let s:session_menu_name = "SessionMenu_"


function! SessionGetFileName()
    return  expand("%:p:h:t")
endfunction


function! SessionGetFileFullPath()
        return glob(s:sessions_data_path) . SessionGetFileName()
endfunction


function! SessionCreate(ses_file)
    echo "New session created: ". a:ses_file
    exe "mksession! ". a:ses_file
endfunction


function! SessionNew()
    let l:ses_file = substitute(input("Enter session name: "), "\\W", "_", "g" )
    let l:ses_file = substitute(l:ses_file, "_\*$", "", "g")
    call SessionCreate(glob(s:sessions_data_path) . l:ses_file)
    call SessionManagerReload()
endfunction


function! SessionSave()
    if v:this_session == ""
        call SessionNew()
    else
        exe "mksession! ". v:this_session
        echo "Session update: ". v:this_session
    endif
endfunction


function! SessionLoad(ses_file)
    let l:ses_file = glob(s:sessions_data_path) . a:ses_file
    try
        exec "so ". l:ses_file
    catch E445
        let l:answer = input("Unsaved buffers. Save and load new session? [y/N]: ")
        if l:answer != "y"
            return
        endif
    endtry
    wa!
    exec "so ". l:ses_file
    call SessionManagerClose()
    echo "Loaded session: ". l:ses_file
endfunction


function! SessionDelete(ses_file)
    let l:ses_file = glob(s:sessions_data_path) . a:ses_file
    silent! exe "!rm -r ". l:ses_file
    call SessionManagerReload()
    redraw!
endfunction


function! SessionDeleteSelected()
    call SessionDelete(getline(line('.')))
endfunction


function! SessionLoadSelected()
    call SessionLoad(getline(line(".")))
endfunction


function! SessionManagerClose()
    exec ":".bufnr(s:session_menu_name)." bwipeout"
endfunction


function! SessionManagerReload()
    call SessionManagerClose()
    call SessionManagerOpen()
endfunction


function! SessionManagerOpen()
    exec "silent! ". 22 . " vne ". s:session_menu_name
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
    
    for sesfile in split(glob(s:sessions_data_path."*"), "\n")
        let l:sesfilename = fnamemodify(sesfile, ":t:r")
        call append(line("$"), l:sesfilename)
    endfor
    sort iu
    norm gg"_dd
    setl noinsertmode
    setl nomodifiable

    nnoremap <silent> <buffer> <CR>  :call SessionLoadSelected()<CR>
    nnoremap <silent> <buffer> o     :call SessionLoadSelected() <CR>
    nnoremap <silent> <buffer> s     :call SessionSave() <CR>
    nnoremap <silent> <buffer> n     :call SessionNew() <CR>
    nnoremap <silent> <buffer> c     :call SessionNew() <CR>
    nnoremap <silent> <buffer> d     :call SessionDeleteSelected() <CR>
    nnoremap <silent> <buffer> q     :call SessionManagerClose() <CR>

    syntax match Underline /.*\%#.*/
    autocmd  BufLeave <buffer>       call SessionManagerClose()
endfunction


function! SessionManagerToggle()
    " toggle 
    if bufexists(bufnr(s:session_menu_name))
        call SessionManagerClose()
        return
    endif
    call SessionManagerOpen()
endfunction

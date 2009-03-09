let s:sessions_data_path = "~/.vim_sessions/"




function! GetSessionFileName()
    return  substitute(expand("%:p:h"), "/", "_", "g")
endfunction


function! GetSessionFilePath()
        return glob(s:sessions_data_path) . GetSessionFileName()
endfunction


function! SaveSession()
    if v:this_session != ""
        let l:session_file = v:this_session
        echo "Session update: ". l:session_file
    else
        let l:session_file = GetSessionFilePath()
        echo "New session created: ". l:session_file
    endif 
    "wa!
    exe "mksession! ". l:session_file
endfunction


function! LoadSession()
        echo "Loading session: ". GetSessionFileName()
        let l:session_file = GetSessionFilePath()
        exec "so ". l:session_file
endfunction


function! ManageSession()
    let l:session_file = GetSessionFilePath()
    
    if v:this_session != ""
        call SaveSession()
        return
    endif

    for sesfile in split(glob(s:sessions_data_path . "*"), "\n")
        if l:session_file == sesfile
            call LoadSession()
            return
        endif
    endfor

    call SaveSession()
endfunction


function! ManageSessionMenu()
    " TODO
endfunction


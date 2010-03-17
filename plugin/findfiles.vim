" File:                findfiles.vim
" Author:              Piotr Husiatyński <phusiatynski@gmail.com>
" Version:             1.0
" Licence:             MIT Licence


let s:max_buff_height = 30


function! Find(name)
	let l:filelist = split(system("find . -iname '". a:name ."'"), '\n')
	if len(l:filelist) == 0
		echo "No files found"
		return
	endif
	let l:buff_name = 'Find file (' . len(l:filelist) . ') : '. a:name
	let l:buff_height = s:max_buff_height
	if len(l:filelist) < l:buff_height
		let l:buff_height = len(l:filelist)
	endif
	setl splitbelow
	exec 'silent! '. l:buff_height . ' split '. l:buff_name
	setl noshowcmd
	setl noswapfile
	setl nowrap
	setl nonumber
	setl nospell
	setl cursorline
	setl modifiable
	setl buftype=nofile
	setl bufhidden=delete
	for file_path in l:filelist
		call append(line('$'), l:file_path)
	endfor
	norm gg"_dd
	setl nomodifiable
	setl noinsertmode
	
	noremap <silent> <buffer> <CR>  :call FindFileOpen()<CR>
    	map     <silent> <buffer> q     :q!<CR> 
endfunction

function! FindFileOpen()
	let l:file_path = getline(line('.'))
	wincmd k
	exec "edit ". l:file_path
	wincmd j
endfunction


command! -nargs=1 Find :call Find("<args>")

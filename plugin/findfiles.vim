" File:                findfiles.vim
" Author:              Piotr Husiatyński <phusiatynski@gmail.com>
" Version:             1.01
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
	call FindFileShowResults(l:filelist, l:buff_name, l:buff_height)
endfunction

function! FindSelected()
	let l:search_str = expand("<cword>")
	if len(l:search_str) == 0
		echo "Select any string before using this search"
		return
	endif
	let l:search_str = '*'. l:search_str .'*'
	call Find(l:search_str)
endfunction

function! FindFileShowResults(results, buff_name, buff_height)
	setl splitbelow
	exec 'silent! '. a:buff_height . ' split '. a:buff_name
	setl noshowcmd
	setl noswapfile
	setl nowrap
	setl nonumber
	setl nospell
	setl cursorline
	setl modifiable
	setl buftype=nofile
	setl bufhidden=delete
	for file_path in a:results
		call append(line('$'), l:file_path)
	endfor
	norm gg"_dd
	setl nomodifiable
	setl noinsertmode
	
	noremap <silent> <buffer> <CR>  :call FindFileOpen()<CR>
	map     <silent> <buffer> o     :call FindFileOpenClose()<CR>
    	map     <silent> <buffer> q     :call FindFileClose()<CR> 
endfunction

function! FindFileOpen()
	let l:file_path = getline(line('.'))
	wincmd k
	exec "edit ". l:file_path
	wincmd j
endfunction

function! FindFileOpenClose()
	call FindFileOpen()
	call FindFileClose()
endfunction

function! FindFileClose()
	bdelete "Find file (*"
endfunction


command! -nargs=1 Find :call Find("<args>")
map      <Leader>Find  <Esc>:call FindSelected()<CR>

" tricky xmodmap change usage

map  <F10>  :cn<CR>
imap <F10>  <Esc>:cn<CR>

map  <F9>   :TlistToggle<CR>
imap <F9>   <Esc>:TlistToggle<CR>

imap <F8>   <Esc>:NERDTreeToggle<CR><Esc>
map  <F8>   :NERDTreeToggle<CR><Esc>

" {{{ tab move
map      <C-t>      :tabnew<CR>
imap     <C-t>      :<Esc>tabnew<CR>i
map      <M-h>      :tabprev<CR>
imap     <M-h>      :<Esc>tabprev<CR>i
map      <M-l>      :tabnext<CR>
imap     <M-l>      :<Esc>tabnext<CR>i
" }}}

" {{{ window move
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" }}}

" {{{ various
map      <leader>=      maHmbgg=Gg'bztg`a
map      <Leader>de     :%s/\s\+$//<CR>
map      <Leader>spell  <Esc>:set spelllang=pl<CR><Esc>:set spell<CR>
map      <Leader>color  <Esc>:call ColorschemeChooserToggle()<CR>
map      <Leader>cc     <Esc>:call ColorSelector()<CR>
map      <Leader>ma     <Esc>1GgqG<CR>`a
" }}}

map      <Leader>t      <Esc>:il TODO\|FIXME\|REMOVE\|FIX <CR>

map      <Leader>note   <Esc>:tabnew ~/.vimnotes<CR><Esc>:set ft=rst<CR>

" {{{ mouse keys
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
imap <S-Insert> <MiddleMouse>
" }}}

" {{{ latex
imap <C-i> <Esc>bcw\textit{}<Esc>hpi
" }}}

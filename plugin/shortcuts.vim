" tricky xmodmap change usage

map  <F10>  :cn<CR>
imap <F10>  <Esc>:cn<CR>

map  <F9>   :TlistToggle<CR>
imap <F9>   <Esc>:TlistToggle<CR>

imap <F8>   <Esc>:NERDTreeToggle<CR><Esc>
map  <F8>   :NERDTreeToggle<CR><Esc>

nmap     <C-t>          :tabnew<CR>
nmap     <C-c>          :tabclose<CR>
map      <C-left>       :tabprev<CR>
imap     <C-left>       <Esc>:tabprev<CR><insert>
map      <C-right>      :tabnext<CR>
imap     <C-right>      <Esc>:tabnext<CR><insert>

map      <leader>=      maHmbgg=Gg'bztg`a
map      <Leader>de     :%s/\s\+$//<CR>
map      <Leader>spell  <Esc>:set spelllang=pl<CR><Esc>:set spell<CR>
map      <Leader>color  <Esc>:call ColorschemeChooserToggle()<CR>
map      <Leader>ma     <Esc>1GgqG<CR>`a

map      <Leader>t      <Esc>:il TODO\|FIXME\|REMOVE\|FIX <CR>

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
imap <S-Insert> <MiddleMouse>


inoremap /**   /*<Space><Space>*/<Left><Left><Left>

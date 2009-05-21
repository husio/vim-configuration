" tricky xmodmap change usage

map  «      :silent! make<CR><C-l>:cc<CR>
imap «      <Esc>:silent! make<CR><C-l>:cc<CR>
map  »      :call RunMake()<CR>
imap »      <Esc>:call RunMake()<CR>

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

map      <S-Insert>     <SID>Paste
imap     <S-Insert>     <Esc><SID>Paste


map      <leader>=      maHmbgg=Gg'bztg`a
map      <Leader>de     :%s/\s\+$//<CR>
map      <Leader>spell  <Esc>:set spelllang=pl<CR><Esc>:set spell<CR>
map      <Leader>color  <Esc>:call ColorschemeChooserToggle()<CR>
map      <Leader>ma     <Esc>1GgqG<CR>`a

" close pairs
inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

inoremap /**   /*<Space><Space>*/<Left><Left><Left>

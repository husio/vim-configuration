" tricky xmodmap change usage

function! RunMake()
    exec "silent ! xterm -e '~/.vim/sh/runmake.sh ". &makeprg ." ". expand("%:p") ."' &"
endfunction

map  «      :silent! make<CR><C-l>:cc<CR>
imap «      <Esc>:silent! make<CR><C-l>:cc<CR>
map  »      :call RunMake()<CR>
imap »      <Esc>:call RunMake()<CR>

nmap <F12>  :call SessionManagerToggle()<CR>

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

" close pairs
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {}<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     ()<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     []<Left>

inoremap /**   /*<Space><Space>*/<Left><Left><Left>

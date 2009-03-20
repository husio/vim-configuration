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

map <C-b>   :MiniBufExplorer<CR>
map <C-c>   :CMiniBufExplorer<CR>

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
map      <Leader>l      <Esc>:call EasyFinderToggle()<CR>
map      <Leader>ma     <Esc>1GgqG<CR>`a

imap     <M-_>          <C-R>=GetCloseTag()<CR>

iab _viminfo vim:filetype=c:expandtab:shiftwidth=4:tabstop=4:softtabstop=4:encoding=utf-8:textwidth=80
iab _date <c-r>=strftime('%d.%m.%Y  %H:%M')<CR>
iab _todo <c-r>=strftime('TODO [ %H:%M - %d.%m.%Y ]')<CR>


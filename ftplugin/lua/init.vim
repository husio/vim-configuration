setlocal makeprg=lua\ -e\ \"package.path=package.path..';/home/piotrek/.lua/?.lua'\"\ -l\ autoload\ % 
setlocal errorformat=lua:\ %f:%l:%m

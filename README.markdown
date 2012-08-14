
Installation:
=============

Install additional apps:
-----------------------

Required apps are:

* Vim >= 7.1 with Python support


Make old Vim configuration backup
---------------------------------

If you have old Vim configuration, make backup first:

    $ mv ~/.vim ~/.vim_old
    $ mv ~/.vimrc ~/.vimrc_old


Clone and install
-----------------

Then, clone my files to `~/.vim` and make symlink to `~/.vim/vimrc`:

    $ git clone git://github.com/husio/vim-configuration.git ~/.vim
    $ ln -s ~/.vim/vimrc ~/.vimrc

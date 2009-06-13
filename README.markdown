
Installation:
=============

Install additional apps:
-----------------------

Required apps are:

* Vim!
* [pyflakes](http://divmod.org/trac/wiki/DivmodPyflakes) - only for Python files
* grep, fgrep, egrep, agrep, find, xargs


Make old Vim configuration backup
---------------------------------

If you have old Vim configuration, make backup first:

    mv ~/.vim ~/.vim_old
    mv ~/.vimrc ~/.vimrc_old


Clone and install
-----------------

Then, clone my files to `~/.vim` and make symlink to `~/.vim/vimrc`:

    git clone git://github.com/husio/vim-configuration.git .vim
    ln -s ~/.vim/vimrc ~/.vimrc



Even more features you may want to know
=======================================

Cscope
------

Instead of greping the code...

First of all, install [cscope](http://cscope.sourceforge.net/). Then, check if
you do have your Vim compiled with `--enable-cscope` flag. If so, create source
code files index. For example, for my Python project I would type:

    $ cd my_python_project/src
    $ find . -iname "*.py" > cscope.files
    $ cscope -b -i cscope.files

Done. Now run `vim` and type `:cs`. Cscope is designed for C source code, but it
does work with any text files.

See also [:h cscope](http://www.vim.org/htmldoc/if_cscop.html#Cscope).
[Automatically create and update cscope
database?](http://vim.wikia.com/wiki/Automatically_create_and_update_cscope_database)

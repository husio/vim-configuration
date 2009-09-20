
Installation:
=============

Install additional apps:
-----------------------

Required apps are:

* Vim >= 7.1 with Python support
* grep, fgrep, egrep, agrep, find, xargs


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



Even more features you may want to know
=======================================

Ctags & Python
--------------

How to use [ctags](http://ctags.sourceforge.net/) with python projects? First
of all, generate `tags` file:

    $ cd myproject
    $ find . -name "*.py" | xargs ctags -a

Done. Now `:tag <name>` will `goto` that name, same as `C^] g` with cursor on
some name. More info [:h Exuberant_ctags](http://vimdoc.sourceforge.net/htmldoc/tagsrch.html#Exuberant_ctags)

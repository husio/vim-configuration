## Installation



If you have an old Vim configuration make a backup first:

    $ mv ~/.vim ~/.vim_old

Clone this repository to `~/.vim`. For most plugins am using [git
submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to manage
dependencies, so make sure to fetch those as well.

    $ git clone --recurse-submodules git://github.com/husio/vim-configuration.git ~/.vim

To upgrade managed as git submodules plugins run

    $ make up

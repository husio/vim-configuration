" Vim compiler file
" Compiler:	    pyflakes
" Maintainer:	Piotr Husiatyński <phusiatynski@gmail.com>
" Last Change:  2008 Jul 1

let current_compiler = "pyflakes"

if exists(":CompilerSet") != 2		
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=%f:%l:\ %m
CompilerSet makeprg=/usr/bin/pyflakes\ %

" Vim compiler file
" Compiler:	    Lua
" Maintainer:	Piotr Husiatyński <phusiatynski@gmail.com>
" Last Change:  2008 Jul 1

if exists("current_compiler")
  finish
endif
let current_compiler = "lua"

if exists(":CompilerSet") != 2		
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat=lua:\ %f:%l:%m
CompilerSet makeprg=lua\ %

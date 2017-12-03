call plug#begin('~/.vim/plugged')

Plug 'derekwyatt/vim-scala'
Plug 'ktvoleker/sbt-vim'

call plug#end()

setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal formatoptions=croql
syntax on

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/indentpython.vim'

call plug#end()

" Python specific settings.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal formatoptions=croql
let python_highlight_all=1
syntax on

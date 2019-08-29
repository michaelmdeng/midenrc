let g:python_host_prog="~/.virtualenvs/nvim2/bin/python"
let g:python3_host_prog="~/.virtualenvs/nvim3/bin/python"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Cmd preview
set inccommand=nosplit

setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=80
setlocal colorcolumn=81
setlocal formatoptions=croql
setlocal foldmethod=indent
syntax on

" vim-scala
let g:scala_scaladoc_indent = 1
let g:scala_sort_across_groups=1
let g:scala_use_default_keymappings = 0
let g:scala_user_default_keymappings=0

nmap <leader>si :SortScalaImports<CR>
nmap <leader>ap :ScAddPackage<CR>
nmap <leader>ac :ScAddClass<CR>
nmap <leader>at :ScAddTrait<CR>
nmap <leader>ao :ScAddObject<CR>

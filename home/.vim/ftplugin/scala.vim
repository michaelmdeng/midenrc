setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=80
setlocal colorcolumn=81
setlocal formatoptions=croql
syntax on

nnoremap <leader>t :EnType<CR>
nnoremap <C-r>r :EnRename<CR>
nmap <leader>ai :EnSuggestImport<CR>
nmap <leader>df :EnDeclaration<CR>
nmap <leader>dc :EnUsages<CR>
nmap <leader>c :EnTypeCheck<CR>
nmap <leader>si :SortScalaImports<CR>

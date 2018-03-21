setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=99
setlocal colorcolumn=100
setlocal formatoptions=croql
syntax on

nnoremap <leader>t :EnType<CR>
nnoremap <C-r>r :EnRename<CR>
nmap <leader>si :EnSuggestImport<CR>
nmap <leader>df :EnDeclaration<CR>
nmap <leader>dc :EnUsages<CR>
nmap <leader>c :EnTypeCheck<CR>

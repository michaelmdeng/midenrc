setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=80
setlocal colorcolumn=81
setlocal formatoptions=croql
setlocal foldmethod=indent
setlocal foldlevel=99
syntax on

nmap <F5> :EnDebugContinue<CR>
nmap <C-F5> :EnDebugContinue<CR>
nmap <F9> :EnDebugSetBreak<CR>
nmap <leader><F9> :EnDebugClearBreak<CR>
nmap <F10> :EnDebugNext<CR>
nmap <F11> :EnDebugStep<CR>
nmap <leader><F11> :EnDebugStepOut<CR>
nmap <leader>bs :EnDebugBacktrace<CR>

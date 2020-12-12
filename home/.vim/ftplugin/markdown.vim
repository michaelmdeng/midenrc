setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=80
setlocal colorcolumn=81
setlocal conceallevel=0
setlocal spell

syntax on

let b:surround_{char2nr('i')} = "*\r*"
let b:surround_{char2nr('b')} = "**\r**"

nmap <buffer> <leader><Space> <Plug>VimwikiToggleListItem

" Restore <C-Up>, <C-Down>
nmap <buffer> gwd <Plug>VimwikiDiaryPrevDay
nmap <buffer> gwD <Plug>VimwikiDiaryNextDay

nmap <buffer> <leader>wr :Vimwiki2HTML<cr>
nmap <buffer> <leader>wR :VimwikiAll2HTML<cr>
nmap <buffer> <leader>wo :Vimwiki2HTMLBrowse<cr>

nmap <buffer> <Leader>wl <Plug>VimwikiFollowLink
nmap <buffer> <Leader>wls <Plug>VimwikiSplitLink
nmap <buffer> <Leader>wlv <Plug>VimwikiVSplitLink

nmap <buffer> <C-]> <Plug>VimwikiFollowLink
nmap <buffer> <C-s>] <Plug>VimwikiSplitLink
nmap <buffer> <C-v>] <Plug>VimwikiVSplitLink

vmap <buffer> <C-]> <Plug>VimwikiNormalizeLinkVisual
vmap <buffer> <C-s>] <Plug>VimwikiSplitLink
vmap <buffer> <C-v>] <Plug>VimwikiVSplitLink

setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=90
setlocal colorcolumn=91
setlocal conceallevel=0
setlocal spell

syntax on

let b:surround_{char2nr('i')} = "*\r*"
let b:surround_{char2nr('b')} = "**\r**"

nmap <buffer> <leader><Space> <Plug>VimwikiToggleListItem

" Restore <C-Up>, <C-Down>
nmap <buffer> gwd <Plug>VimwikiDiaryPrevDay
nmap <buffer> gwD <Plug>VimwikiDiaryNextDay

nmap <buffer> <leader>wr :!mdcli wiki convert "%:p"<cr>
nmap <buffer> <leader>wR :!mdcli wiki transform ~/MyDrive/vimwiki/wiki<cr>
nmap <buffer> <leader>wo :!mdcli wiki open -b open "%:p"<cr>

nnoremap <buffer> <Leader>wl <Plug>VimwikiFollowLink
nnoremap <buffer> <Leader>wls <cmd>VimwikiSplitLink<cr>
nnoremap <buffer> <Leader>wlv <cmd>VimwikiVSplitLink<cr>

nnoremap <buffer> <C-]> <Plug>VimwikiFollowLink
nnoremap <buffer> <C-s>] <cmd>VimwikiSplitLink<cr>
nnoremap <buffer> <C-s><C-]> <cmd>VimwikiSplitLink<cr>
nnoremap <buffer> <C-v>] <cmd>VimwikiVSplitLink<cr>
nnoremap <buffer> <C-v><C-]> <cmd>VimwikiVSplitLink<cr>

vnoremap <buffer> <C-]> <Plug>VimwikiNormalizeLinkVisual
vnoremap <buffer> <C-s>] <cmd>VimwikiSplitLink<cr>
vnoremap <buffer> <C-s><C-]> <cmd>VimwikiSplitLink<cr>
vnoremap <buffer> <C-v>] <cmd>VimwikiVSplitLink<cr>
vnoremap <buffer> <C-v><C-]> <cmd>VimwikiVSplitLink<cr>

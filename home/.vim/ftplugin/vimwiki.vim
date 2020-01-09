setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal textwidth=79
setlocal colorcolumn=80
setlocal foldlevel=99
setlocal conceallevel=0

syntax on

nmap <Leader>wl <Plug>VimwikiFollowLink
nmap <Leader>wls <Plug>VimwikiSplitLink
nmap <Leader>wlv <Plug>VimwikiVSplitLink

" Remove <Plug>VimwikiGoBackLink
silent! nunmap <buffer> <BS>

" Remove <Plug>VimwikiPrevLink, <Plug>VimwikiNextLink
silent! nunmap <buffer> <Tab>
silent! nunmap <buffer> <S-Tab>

" Remove <Plug>VimwikiAddHeaderLevel
silent! nunmap <buffer> =

" Remove <Plug>VimwikiRemoveHeaderLevel
silent! nunmap <buffer> -

" Remove <Plug>VimwikiGoToPrevHeader, <Plug>VimwikiGoToNextHeader
silent! nunmap <buffer> ]]
silent! nunmap <buffer> [[

" Remove <Plug>VimwikiGoToPrevSiblingHeader, <Plug>VimwikiGoToNextSiblingHeader
silent! nunmap <buffer> ]=
silent! nunmap <buffer> [=

" Remove <Plug>VimwikiGoToParentHeader
silent! nunmap <buffer> ]u
silent! nunmap <buffer> [u

nmap <leader><Space> <Plug>VimwikiToggleListItem

" Restore <C-Up>, <C-Down>
nmap gwd <Plug>VimwikiDiaryPrevDay
nmap gwD <Plug>VimwikiDiaryNextDay

nmap <C-]> <Plug>VimwikiFollowLink

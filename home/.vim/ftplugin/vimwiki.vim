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

nmap <buffer> <leader><Space> <Plug>VimwikiToggleListItem

" Restore <C-Up>, <C-Down>
nmap <buffer> gwd <Plug>VimwikiDiaryPrevDay
nmap <buffer> gwD <Plug>VimwikiDiaryNextDay

nmap <buffer> <Leader>wl <Plug>VimwikiFollowLink
nmap <buffer> <Leader>wls <Plug>VimwikiSplitLink
nmap <buffer> <Leader>wlv <Plug>VimwikiVSplitLink

nmap <buffer> <C-]> <Plug>VimwikiFollowLink

vmap <buffer> <C-]> <Plug>VimwikiNormalizeLinkVisual

" Remove <Plug>VimwikiDecreaseLevel
inoremap <buffer> <C-d> <Del>

setlocal foldmethod=indent
setlocal textwidth=80
setlocal colorcolumn=81

setlocal omnifunc=v:lua.vim.lsp.omnifunc

if HasLsp()
  SetupLsp()
end

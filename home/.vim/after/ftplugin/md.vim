augroup TrimSpaces
  autocmd BufWritePre <buffer> %s/\s\+$//e
augroup end

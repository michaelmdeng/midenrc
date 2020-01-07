nmap <buffer> <leader>d <Plug>(taskwarrior_done)

nmap <buffer> O <Plug>(taskwarrior_new)

nmap <buffer> i <Plug>(taskwarrior_modify_field)
nmap <buffer> I <Plug>(taskwarrior_modify_task)

nmap <buffer> w <Plug>(taskwarrior_step_right)
nmap <buffer> W <Plug>(taskwarrior_skip_right)

nmap <buffer> b <Plug>(taskwarrior_step_left)

" Sync on save
ca <buffer> e TW
ca <buffer> w call taskwarrior#action#sync('sync')
ca <buffer> W call taskwarrior#action#sync('sync')

" augroup TaskWarriorSync
"   autocmd 
" augroup end

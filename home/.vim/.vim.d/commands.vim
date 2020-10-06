" COMMANDS
" Disable \"Hit enter to continue\" in vim run command
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'

" Increment/Decrement numbers by search
" :let i=x0 g/pattern/s//\='pattern'.i/ | let i=i+1/

" AUTO COMMANDS
" Reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * Silent echo -ne "\e[2 q"
augroup END

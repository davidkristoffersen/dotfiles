fun CommandsInit()
	" Disable \"Hit enter to continue\" in vim run command
	command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'

	" Increment/Decrement numbers by search
	" :let i=x0 g/pattern/s//\='pattern'.i/ | let i=i+1/
endfun

fun AutoCommandsInit()
	" Reset cursor on start:
	augroup myCmds
	au!
	autocmd VimEnter * Silent echo -ne "\e[2 q"
	augroup END

	au BufLeave,FocusLost * silent! wa	" Autosave on not using the window

	" Filetype specific
	au Filetype python setl et ts=4 sw=4 softtabstop=4	" Python
	au BufEnter,BufRead *.conf setf dosini 				" Conf files have dosini syntax
	au BufEnter,BufRead *.rasi setf css					" Rasi files have css syntax
endfun
call CommandsInit()
call AutoCommandsInit()

fu CommandsInit()
	" Disable 'Hit enter to continue' in vim run command
	command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
endf

fu AutoCommandsInit()
	""" Reset cursor on start
	au VimEnter * Silent echo -ne '\e[2 q'
	au BufLeave,FocusLost * silent! wa		" Autosave on not using the window
	au VimEnter * :call ForceSyntax()		" Force syntax

	" Filetype specific
	au Filetype python setl et ts=4 sw=4 sts=4	" Python
	au BufEnter,BufRead *.conf setf dosini		" Conf files have dosini syntax
	au BufEnter,BufRead *.rasi setf css			" Rasi files have css syntax
endf

call CommandsInit()
call AutoCommandsInit()

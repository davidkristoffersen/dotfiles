fu FunctionsInit()
	" Force syntax
	fu g:ForceSyntax()
		let l:name=expand('%t')
		if l:name =~? '^.*.dir_colors.*'
			set syntax=dircolors
		endif
	endf

	" Toggle option and print value
	fu ToggleOption(option)
		exec 'set ' . a:option . '!'
		exec 'set ' . a:option . '?'
	endf

	" OS clipboard yank
	fu ClipboardYank()
		call system('xclip -i -selection clipboard', @@)
	endf
	" OS clipboard paste
	fu ClipboardPaste()
		let @@ = system('xclip -o -selection clipboard')
	endf
endf

call FunctionsInit()

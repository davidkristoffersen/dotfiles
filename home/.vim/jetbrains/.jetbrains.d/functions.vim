fu FunctionsInit()
	" Toggle option and print value
	fu ToggleOption(option)
		exec 'set ' . a:option . '!'
		exec 'set ' . a:option . '?'
	endf
endf

call FunctionsInit()

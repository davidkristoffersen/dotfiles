fun HighlightInit()
	colo desert	" Color scheme

	" Search menu not selected
	hi Pmenu ctermfg=7 ctermbg=237
	" Search menu selected
	hi Pmenusel ctermfg=237 ctermbg=214
	" Search results
	hi Search ctermfg=16 ctermbg=240
	" Mid search first match
	hi IncSearch ctermfg=16 ctermbg=255
	" Visual mode
	hi Visual ctermfg=248 ctermbg=16
	" Error highlighting
	hi Error ctermfg=Red ctermbg=black
endfun
call HighlightInit()

fun! s:plugin()
	let g:indent_guides_enable_on_vim_startup = 1

	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239

	let g:indent_guides_start_level=1
	let g:indent_guides_guide_size=1
endfun

call s:plugin()

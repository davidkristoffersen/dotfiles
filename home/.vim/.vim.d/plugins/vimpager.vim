function! g:Plugin_vimpager()
	if !exists('g:vimpager')
		let g:vimpager = {}
	endif

	if !exists('g:less')
		let g:less	 = {}
	endif
	let g:less.enabled = 0
endfunction

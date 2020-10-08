fun! s:plugin()
	" Use omnisharp for c# files
	let g:ale_linters = { 'cs': ['OmniSharp'] }
endfun

call s:plugin()

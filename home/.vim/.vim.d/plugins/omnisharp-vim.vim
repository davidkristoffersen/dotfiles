fun! s:plugin()
	" Stdio version of OmniSharp-roslyn
	let g:OmniSharp_server_stdio = 1
	" Update semantic highlighting after all text changes
	let g:OmniSharp_highlight_types = 3
	" Timeout in seconds to wait for a response from the server
	let g:OmniSharp_timeout = 5
	" Set preview window height for viewing documentation
	set previewheight=5
	set completeopt=
		\ longest,	" Don't autoselect first option
		\ menuone,	" Show menu on only one option
		\ preview	" Show extra documentation info
endfun

call s:plugin()

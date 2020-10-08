fun! s:plugin()
	" Use the stdio version of OmniSharp-roslyn:
	let g:OmniSharp_server_stdio = 1
	" Update semantic highlighting after all text changes
	let g:OmniSharp_highlight_types = 3
	" Timeout in seconds to wait for a response from the server
	let g:OmniSharp_timeout = 5
	" Set desired preview window height for viewing documentation.
	set previewheight=5
	" Don't autoselect first omnicomplete option, show options even if there is only one
	" Remove 'preview' if you don't want to see any documentation whatsoever.
	set completeopt=longest,menuone,preview
endfun
call s:plugin()

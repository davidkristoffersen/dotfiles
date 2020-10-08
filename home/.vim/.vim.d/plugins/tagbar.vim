fun! s:plugin()
	nmap <leader>t :TagbarToggle<CR>
	endfunction

	" VIM TRAILING WHITESPACE
	function! g:Plugin_vim_trailing_whitespace()
	nmap <leader>F :FixWhitespace<CR>
endfun

call s:plugin()

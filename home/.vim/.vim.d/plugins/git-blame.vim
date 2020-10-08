fun! s:plugin()
	" Echo current line's git blame
	nnoremap <leader>b :call gitblame#echo()<CR>
endfun

call s:plugin()

fun! s:plugin()
	nnoremap <leader>b :<C-u>call gitblame#echo()<CR>
endfun
call s:plugin()

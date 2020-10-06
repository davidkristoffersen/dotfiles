function! g:Plugin_git_blame()
	nnoremap <leader>b :<C-u>call gitblame#echo()<CR>
endfunction

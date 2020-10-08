fun MapLeaderInit()
	" Extended normal mode commands
	noremap <leader>jj 50j<C-e><cr>
	noremap <leader>kk 50k<C-y><cr>

	" Preserve paste
	vnoremap <leader>p "_dP

	" Soft2Hard tabs
	nmap <leader>T :%s/\s\s\s\s/\t/g<cr>
	" Hard2Soft tabs
	nmap <leader>H :%s/\t/	/g<cr>

	" Move tab next
	nnoremap <leader>} :tabm +1<cr>
	" Move tab prev
	nnoremap <leader>{ :tabm -1<cr>
	" Move tab next
	nnoremap <leader>] :tabn<cr>
	" Move tab prev
	nnoremap <leader>[ :tabp<cr>

	" Reverse search
	nnoremap <leader>r q:?

	" Clear search
	nnoremap <leader>o :noh<cr>

	" Leader for navigating vimsplit
	nnoremap <leader>j :wincmd j<CR>
	nnoremap <leader>k :wincmd k<CR>
	nnoremap <leader>l :wincmd l<CR>
	nnoremap <leader>h :wincmd h<CR>

	" Toggling
	nnoremap <leader>tp :call ToggleOption('paste')<cr>
	nnoremap <leader>tn :call ToggleOption('number')<cr>
	nnoremap <leader>tc :call ToggleOption('spell')<cr>
	nnoremap <leader>ts :SyntasticToggleMode<cr>

	" Comment out/in line
	nnoremap <leader>c :call CommenterToggle()<cr>

	" Save
	nmap <leader>w :w!<cr>
endfun

call MapLeaderInit()

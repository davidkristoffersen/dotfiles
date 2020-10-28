fu MapLeaderInit()
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
	" Fuzzy open file at tab next
	nnoremap <leader>f] :tabe <bar> Files<cr>
	" Fuzzy open file at tab prev
	nnoremap <leader>f[ :tabe <bar> tabm -1 <bar> Files<cr>

	" Fuzzy lines search
	nnoremap <leader>fl :BLines<cr>
	" Fuzzy file search
	nnoremap <leader>ff :Files<cr>
	" Fuzzy history search
	nnoremap <leader>fF :History<cr>
	" Fuzzy command search
	nnoremap <leader>fr :History:<cr>
	" Fuzzy search search
	nnoremap <leader>f/ :History/<cr>

	" Clear search
	nnoremap <leader>o :noh<cr>

	" Opening vimsplit
	nnoremap <leader>fh :split <bar> Files<cr>
	nnoremap <leader>fv :vsplit <bar> Files<cr>

	" Navigating vimsplit
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
	" nnoremap <leader>c :call CommenterToggle()<cr>

	" Save
	nmap <leader>w :w!<cr>
	" Save and quit
	nmap <leader>q :wq<cr>
	" Force quit
	nmap <leader>Q :q<cr>
endf

call MapLeaderInit()

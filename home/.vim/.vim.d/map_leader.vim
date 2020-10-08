" MAPS: LEADER SPECIFIC
fun MapLeaderInit()
	let mapleader = " "
	" Time before keykode or leader terminated
	set timeout ttimeoutlen=50

	" Extended normal mode commands
	noremap <leader>jj :call ManyDown()<cr>
	noremap <leader>kk :call ManyUp()<cr>

	" Remove soft tabs
	nmap <leader>T :%s/\s\s\s\s/\t/g<cr>
	" Remove hard tabs
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
	nnoremap <leader>j <C-W><C-J>
	nnoremap <leader>k <C-W><C-K>
	nnoremap <leader>l <C-W><C-L>
	nnoremap <leader>h <C-W><C-H>

	" Comment out/in line
	nnoremap <leader>c :call CommenterToggle()<cr>

	" Save
	nmap <leader>w :w!<cr>

	" ALT KEY
	" Mapping Alt keycode to POSIX standar Alt keycode
	for i in range(char2nr('a'), char2nr('z'))
		let i = nr2char(i)
		exec "set <A-".i.">=\e".i
		exec "imap \e".i." <A-".i.">"
	endfor
	" Move lines up or down with <A-{j/k}>
	nnoremap <A-j> :m+<CR>==
	nnoremap <A-k> :m-2<CR>==
	vnoremap <A-j> :m '>+<CR>gv=gv
	vnoremap <A-k> :m '<-2<CR>gv=gv
	inoremap <A-j> <Esc>:m+<CR>==gi
	inoremap <A-k> <Esc>:m-2<CR>==gi
endfun
call MapLeaderInit()

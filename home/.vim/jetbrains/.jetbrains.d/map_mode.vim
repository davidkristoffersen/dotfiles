fu MapInit()
	" Keep selection when indenting
	vnoremap > >gv
	vnoremap < <gv

	" Disable Arrow keys in Escape mode
	noremap <up> <nop>
	noremap <down> <nop>
	noremap <left> <nop>
	noremap <right> <nop>
	" Disable Arrow keys in Insert mode
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>

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
endf

call MapInit()

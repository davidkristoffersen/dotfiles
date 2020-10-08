fun MapInit()
	" Keep selection when indenting/outdenting.
	vnoremap > >gv
	vnoremap < <gv

	vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
	map <C-v> :r ~/.vimbuffer<CR>
	vnoremap <leader>p "_dP

	" vnoremap <silent> y y:call ClipboardYank()<cr>
	" vnoremap <silent> d d:call ClipboardYank()<cr>
	" nnoremap <silent> p :call ClipboardPaste()<cr>p
	" onoremap <silent> y y:call ClipboardYank()<cr>
	" onoremap <silent> d d:call ClipboardYank()<cr>

	" Disable Arrow keys in Escape mode
	noremap <up> <nop>
	noremap <down> <nop>
	noremap <left> <nop>
	noremap <right> <nop>
	" Disable Arrow keys in Insert mode
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>V
endfun
call MapInit()

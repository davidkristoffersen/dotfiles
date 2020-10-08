fun FunctionsInit()
	" Force syntax
	function! g:ForceSyntax()
		let l:name=expand('%t')
		if l:name =~? '^.*.dir_colors.*'
			set syntax=dircolors
		endif
	endfunction
	autocmd VimEnter * :call ForceSyntax()

	" Toggle commands
	nnoremap <leader>tp :call Toggle_val("set_paste")<cr>
	nnoremap <leader>tn :call Toggle_val("set_number")<cr>
	nnoremap <leader>tc :call Toggle_val("spell_check")<cr>
	nnoremap <leader>ts :call Toggle_val("syntastic")<cr>
	let g:toggles = {'set_paste':	[1, 'set paste', 'set nopaste'],
				\'set_number':	[1, 'set nonumber', 'set number'],
				\'spell_check':	[1, 'set nospell', 'set spell spelllang=en_us',],
				\'syntastic':	[1, 'SyntasticToggleMode', 'SyntasticToggleMode',],
				\}
	function! g:Toggle_val(cmd)
		let g:toggles[a:cmd][0] = xor(g:toggles[a:cmd][0], 1)
		if g:toggles[a:cmd][0] == 0
			execute g:toggles[a:cmd][1]
			echo g:toggles[a:cmd][1]
		else
			execute g:toggles[a:cmd][2]
			echo g:toggles[a:cmd][2]
		endif
	endfunction

	" OS clipboard
	function! ClipboardYank()
		call system('xclip -i -selection clipboard', @@)
	endfunction
	function! ClipboardPaste()
		let @@ = system('xclip -o -selection clipboard')
	endfunction

	function! g:ManyDown()
		for i in range(50)
			exec "normal j\<C-e>"
		endfor
	endfunction
	function! g:ManyUp()
		for i in range(50)
			exec "normal k\<C-y>"
		endfor
	endfunction
endfun
call FunctionsInit()

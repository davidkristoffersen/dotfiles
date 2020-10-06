let g:pathogen_plugins = system("ls -A1 $HOME/.vim/bundle")
" Set disabled plugins
let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'i3-syntax')
call add(g:pathogen_disabled, 'ale')
" call add(g:pathogen_disabled, 'git-blame')

call add(g:pathogen_disabled, 'nerdtree')
call add(g:pathogen_disabled, 'nerdtree-git-plugin')
call add(g:pathogen_disabled, 'omnisharp-vim')

" call add(g:pathogen_disabled, 'syntastic')
" call add(g:pathogen_disabled, 'tagbar')
" call add(g:pathogen_disabled, 'vim-airline')
" call add(g:pathogen_disabled, 'vim-airline-themes')
" call add(g:pathogen_disabled, 'vim-commenter')
" call add(g:pathogen_disabled, 'vim-fugitive')
" call add(g:pathogen_disabled, 'vim-indent-guides')
" call add(g:pathogen_disabled, 'vim-ingo-library')
call add(g:pathogen_disabled, 'vim-javascript')
call add(g:pathogen_disabled, 'vim-jsx')

call add(g:pathogen_disabled, 'vim-nerdtree-tabs')
" WARNING: Very slow
call add(g:pathogen_disabled, 'vimpager')

" call add(g:pathogen_disabled, 'vim-SyntaxRange')
" call add(g:pathogen_disabled, 'vim-trailing-whitespace')

" Load all plugins
execute pathogen#infect()

" PLUGINS MANAGEMENT
" Run plugins that are not disabled
function! Run_plugins()
	for l:plugin in split(g:pathogen_plugins)
		let l:skip = 0
		for l:disabled in g:pathogen_disabled
			if l:plugin == l:disabled
				let l:skip = 1
				continue
			endif
		endfor
		if l:skip
			continue
		endif

		" Replace all '-' with '_'
		let l:fplugin = substitute(l:plugin, "-", "_", "g")
		let l:fplugin = "g:Plugin_" . l:fplugin

		" Run function if it exists
		if eval("exists(\"*" . l:fplugin . "\")")
			exec "call " . l:fplugin . "()"
		endif
	endfor
endfunction
call Run_plugins()

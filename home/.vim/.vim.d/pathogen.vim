fun PathogenInit()
	let l:home = $HOME
	let g:pathogen_plugins = split(system('ls -A1 ' . l:home . '/.vim/bundle'))
	let g:pathogen_disabled = []
	let g:pathogen_enabled = []

	"
	" ENABLED PLUGINS
	"
	
	" call add(g:pathogen_enabled, 'ale')
	call add(g:pathogen_enabled, 'git-blame')
	call add(g:pathogen_enabled, 'i3config.vim')
	" call add(g:pathogen_enabled, 'nerdtree')
	" call add(g:pathogen_enabled, 'nerdtree-git-plugin')
	" call add(g:pathogen_enabled, 'omnisharp-vim')
	call add(g:pathogen_enabled, 'syntastic')
	call add(g:pathogen_enabled, 'tagbar')
	call add(g:pathogen_enabled, 'vim-SyntaxRange')
	call add(g:pathogen_enabled, 'vim-airline')
	call add(g:pathogen_enabled, 'vim-airline-themes')
	call add(g:pathogen_enabled, 'vim-commenter')
	call add(g:pathogen_enabled, 'vim-fugitive')
	call add(g:pathogen_enabled, 'vim-indent-guides')
	call add(g:pathogen_enabled, 'vim-ingo-library')
	" call add(g:pathogen_enabled, 'vim-javascript')
	" call add(g:pathogen_enabled, 'vim-jsx')
	" call add(g:pathogen_enabled, 'vim-nerdtree-tabs')
	call add(g:pathogen_enabled, 'vim-trailing-whitespace')
	" call add(g:pathogen_enabled, 'vimpager') " WARNING: Very slow

	"
	" LOAD PLUGINS
	"

	" Set disabled plugins
	for plugin in g:pathogen_plugins
		let i = index(g:pathogen_enabled, plugin)
		if i < 0
			call add(g:pathogen_disabled, plugin)
		endif
	endfor

	" Start pathogen
	execute pathogen#infect()

	"
	" PLUGIN CONFIGURATION
	"

	let l:plugins_path = l:home . '/.vim/.vim.d/plugins/'
	for l:plugin in g:pathogen_enabled
		let l:file = l:plugins_path . l:plugin . '.vim'
		if filereadable(l:file)
			exec 'source' . l:file
		endif
	endfor
endfun

call PathogenInit()

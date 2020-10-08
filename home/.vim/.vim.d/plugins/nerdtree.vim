fun! s:plugin()
	" NERDTree will be on a new tab
	let g:nerdtree_tabs_open_on_console_startup=1
	" Do not display files
	let NERDTreeIgnore = ['\.pyc$', '__pycache__$']
	" Width #characters
	let NERDTreeWinSize = 20
	" Clean ui
	let NERDTreeMinimalUI = 1
	" Unicode arrows
	let NERDTreeDirArrows = 1

	" Open NERDTree
	nnoremap <leader>n :NERDTreeTabsToggle<CR>
endfun

call s:plugin()

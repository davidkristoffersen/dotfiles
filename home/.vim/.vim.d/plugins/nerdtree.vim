fun! s:plugin()
	" NERDTree will be on new tab
	let g:nerdtree_tabs_open_on_console_startup=1
	" Do not display files
	let NERDTreeIgnore = ['\.pyc$', '__pycache__$']
	" Width in number of characters
	let NERDTreeWinSize = 20
	" Cleaner ui
	let NERDTreeMinimalUI = 1
	" Unicode arrows
	let NERDTreeDirArrows = 1

	" Leader map for opening NERDTree
	nnoremap <leader>n :NERDTreeTabsToggle<CR>
endfun
call s:plugin()

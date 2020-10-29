fu AleInit()
	" Enabled linters
	" let g:ale_linters = { 'cs': ['OmniSharp'] }

	" Enabled fixers
	let g:ale_fixers = {
	\	'javascript': ['prettier'],
	\ 	'css': ['prettier'],
	\ 	'scss': ['prettier'],
	\ 	'html': ['prettier'],
	\ 	'typescript': ['prettier']
	\ }
	let g:ale_fix_on_save = 1
endf

fu FzfInit()
	" let g:airline#extensions#bufferline#enabled = 1
endf

fu GitBlameInit()
	" Echo current line's git blame
	nnoremap <leader>b :call gitblame#echo()<CR>
endf

fu NerdCommenterInit()
	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1

	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1

	" Align line-wise comment delimiters flush left instead of following code indentation
	let g:NERDDefaultAlign = 'left'

	" Set a language to use its alternate delimiters by default
	let g:NERDAltDelims_java = 1

	" Add your own custom formats or override the defaults
	let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1

	" Enable NERDCommenterToggle to check all selected lines is commented or not 
	let g:NERDToggleCheckAllLines = 1
endf

fu NERDTreeInit()
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
endf

fu OmnisharpInit()
	" Stdio version of OmniSharp-roslyn
	let g:OmniSharp_server_stdio = 1
	" Update semantic highlighting after all text changes
	let g:OmniSharp_highlight_types = 3
	" Timeout in seconds to wait for a response from the server
	let g:OmniSharp_timeout = 5
	" Set preview window height for viewing documentation
	set previewheight=5
	" Don't autoselect first option
	" Show menu on only one option
	" Show extra documentation info
	set completeopt=longest,menuone,preview
endf

fu SyntasticInit()
	" Available 'c' checkers
	let g:syntastic_c_checkers = ['gcc', 'mpicc']
endf

fu TagbarInit()
	" Toggle state of tagbar
	nmap <leader>t :TagbarToggle<CR>
endf

fu VimIndentGuidesInit()
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_auto_colors = 0
	au VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
	au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
	let g:indent_guides_start_level=1
	let g:indent_guides_guide_size=1
endf

fu VimTrailingWhiteSpaceInit()
	" Fix whitespace for entire file
	nmap <leader>F :FixWhitespace<CR>
endf

fu VimpagerInit()
	if !exists('g:vimpager')
		let g:vimpager = {}
	endif
	if !exists('g:less')
		let g:less = {}
	endif
	let g:less.enabled = 0
endf

fu VimSyntaxRangeInit()
	fu g:SyntaxLang(filetype, bool='enable') abort
		let l:ft = &ft
		if l:ft == a:filetype
			return
		endif

		let l:wrap = ''
		let l:cpre = '```'
		let l:pre = ''
		let l:post = '$'
		let l:sep = ''
		let l:match_group = 'NonText'
		let l:cmnt_set = 'y'

		let l:cmnt = g:CommenterGetCommentList()

		let l:cmnt[0] = substitute(l:cmnt[0], '\\', '', 'g')
		let l:cmnt[1] = substitute(l:cmnt[1], '\\', '', 'g')
		let l:cmnt[0] = substitute(l:cmnt[0], '''', '\\''', 'g')
		let l:cmnt[1] = substitute(l:cmnt[1], '''', '\\''', 'g')

		if l:cmnt[1] != ''
			let l:cmnt[1] = ' ' . l:cmnt[1]
		endif
		let l:cmnt[0] = l:cmnt[0] . ' '
		if l:cmnt_set == 'n'
			let l:cmnt[0] = ''
			let l:cmnt[1] = ''
		endif

		let l:pre =	l:cmnt[0] . l:wrap . l:pre	. l:sep . l:cpre . a:filetype . l:wrap . l:cmnt[1]
		let l:post =l:cmnt[0] . l:wrap . l:post	. l:sep . l:cpre . a:filetype . l:wrap . l:cmnt[1]

		if a:bool == 'enable'
			let l:cmd = "call SyntaxRange#Include('" . l:pre . "', '" . l:post . "', '" . a:filetype . "', '" . l:match_group . "')"
		else
			let l:cmd = "call SyntaxRange#IncludeEx('start=\"" . l:pre . "\" end=\"" . l:post . "\"', '" . a:filetype . "')"
		endif

		" echo l:cmd
		exec l:cmd
	endf

	fu s:TextEnableCodeSnipAll()
		let l:langs = g:CommenterGetLanguages()
		for l:lang in l:langs
			call g:SyntaxLang(l:lang, 'enable')
		endfor
	endf

	" au VimEnter * call s:_TextEnableCodeSnipAll()
endf

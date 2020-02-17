"
" .vimrc
"

" IMPORTANT: CACHE RETURN FROM PASTEBIN, use vim -b to find ^M, and dos2unix
" to convert
"
" TODO:
" buffer management
" new c file setup
" persistence

" OS
set clipboard=unnamedplus		" OS-wide clipboard
set mouse=a						" mouse integration

" PATHOGEN PLUGINS
let g:pathogen_plugins = system("ls -A1 $HOME/.vim/bundle")
" Set disabled plugins
let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'i3-syntax')
" call add(g:pathogen_disabled, 'ale')
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
" call add(g:pathogen_disabled, 'vim-javascript')
" call add(g:pathogen_disabled, 'vim-jsx')

call add(g:pathogen_disabled, 'vim-nerdtree-tabs')
" WARNING: Very slow
call add(g:pathogen_disabled, 'vimpager')

" call add(g:pathogen_disabled, 'vim-SyntaxRange')
" call add(g:pathogen_disabled, 'vim-trailing-whitespace')

" Load all plugins
execute pathogen#infect()

" GENERAL
set nocompatible				" disable compatibility
set encoding=utf-8
filetype off
filetype plugin indent on		" file specific scripts
syntax on						" syntax highlighting
set number						" line numbers
set backspace=2					" normal backspace
let loaded_matchparen = 0		" disable syntax matching parenthesis
set nofoldenable				" disable folding
set wrap linebreak nolist		" wrap word for word
set noswapfile					" ahhh the zen
au BufLeave,FocusLost * silent! wa	" auto save when user is not using the window
set wildmenu					" command line completion
set foldmethod=indent
set tabpagemax=100
set shell=bash\ --login			" Execute bashrc aliases in ! mode

" COLORS
colo desert

hi Pmenu ctermfg=7 ctermbg=237
hi Pmenusel ctermfg=237 ctermbg=214
hi Search ctermfg=16 ctermbg=245
hi IncSearch ctermfg=16 ctermbg=255
hi Visual ctermfg=248 ctermbg=16
hi Error ctermfg=Red ctermbg=black

" STATUS LINE
set laststatus=2		" always show status line

" SEARCH
set hlsearch			" highlight all matches
set incsearch			" instant highlight
set ignorecase			" ignore case
set smartcase			" use case when uppercase

" HARD TABS
set tabstop=4						 " tab width
set softtabstop=0 noexpandtab
set shiftwidth=4					" shift width
set autoindent						" auto indentation
set breakindent						" Indents word-wrapped lines as much as the 'parent' line
" Ensures word-wrap does not split words
set formatoptions=l
set lbr
au Filetype python setl et ts=4 sw=4 softtabstop=4
" Conf files have dosini syntax
au BufEnter,BufRead *.conf setf dosini
" Rasi files have css syntax
au BufEnter,BufRead *.rasi setf css

" UNDO HISTORY
set undofile					" use an undo file
set undodir=$HOME/.vim/undo		" undo file path
set undolevels=1000
set undoreload=10000


" MAPS: MODE SPECIFIC
" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

" OS clipboard
function! ClipboardYank()
	call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
	let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p
onoremap <silent> y y:call ClipboardYank()<cr>
onoremap <silent> d d:call ClipboardYank()<cr>

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

" MAPS: LEADER SPECIFIC
let mapleader = " "
" Time before keykode or leader terminated
set timeout ttimeoutlen=50

" Extended normal mode commands
noremap <leader>jj :call ManyDown()<cr>
noremap <leader>kk :call ManyUp()<cr>

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

" Remove soft tabs
nmap <leader>T :%s/\s\s\s\s/\t/g<cr>
" Remove hard tabs
nmap <leader>h :%s/\t/	/g<cr>

" Move tab next
nnoremap <leader>} :tabm +1<cr>
" Move tab prev
nnoremap <leader>{ :tabm -1<cr>
" Move tab next
nnoremap <leader>] :tabn<cr>
" Move tab prev
nnoremap <leader>[ :tabp<cr>

" Reverse search
nnoremap <Leader>r q:?

" Leader for navigating vimsplit
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Comment out/in line
nnoremap <leader>c :call CommenterToggle()<cr>

" Save
nmap <leader>w :w!<cr>
" Reload vimrc
nnoremap <leader>rc :edit \| noh<cr>

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

" MAPS: SUBJECT SPECIFIC
" INF_3910
nnoremap <leader>iu :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh u<cr>
" nnoremap <leader>iiu :Silent	/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh uu %<cr>
nnoremap <leader>iiu :call Upload()<cr>
nnoremap <leader>id :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh d<cr>
nnoremap <leader>iid :Silent	/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh dd %<cr>
nnoremap <leader>is :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh s<cr>
nnoremap <leader>ik :Silent		/home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh k<cr>

function! g:Upload()
	exec 'Silent /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh uu ' . expand('%:p')
endfunction

" COMMANDS
" Disable \"Hit enter to continue\" in vim run command
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'

" Increment/Decrement numbers by search
" :let i=x0 g/pattern/s//\='pattern'.i/ | let i=i+1/

" FUNCTIONS
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

"
" PLUGINS
"

" SYNTASTIC
function! g:Plugin_syntastic()
	let g:syntastic_c_checkers = ['gcc', 'mpicc']
endfunction

" NERDTREE
function! g:Plugin_nerdtree()
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
endfunction

" VIM GIT BLAME
function! g:Plugin_git_blame()
	nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>
endfunction

" INDENT GUIDES
function! g:Plugin_vim_indent_guides()
	let g:indent_guides_enable_on_vim_startup = 1

	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239

	let g:indent_guides_start_level=1
	let g:indent_guides_guide_size=1
endfunction

" TAGBAR
function! g:Plugin_tagbar()
	nmap <leader>t :TagbarToggle<CR>
	endfunction

	" VIM TRAILING WHITESPACE
	function! g:Plugin_vim_trailing_whitespace()
	nmap <leader>F :FixWhitespace<CR>
endfunction

" OMNISHARP
function! g:Plugin_omnisharp_vim()
	" Use the stdio version of OmniSharp-roslyn:
	let g:OmniSharp_server_stdio = 1
	" Update semantic highlighting after all text changes
	let g:OmniSharp_highlight_types = 3
	" Timeout in seconds to wait for a response from the server
	let g:OmniSharp_timeout = 5
	" Set desired preview window height for viewing documentation.
	set previewheight=5
	" Don't autoselect first omnicomplete option, show options even if there is only one
	" Remove 'preview' if you don't want to see any documentation whatsoever.
	set completeopt=longest,menuone,preview
endfunction

" ALE
function! g:Plugin_ale()
	" Tell ALE to use OmniSharp for linting C# files, and no other linters.
	let g:ale_linters = { 'cs': ['OmniSharp'] }
endfunction

" VIMPAGER
function! g:Plugin_vimpager()
	if !exists('g:vimpager')
		let g:vimpager = {}
	endif

	if !exists('g:less')
		let g:less	 = {}
	endif
	let g:less.enabled = 0
endfunction

" SYNTAXRANGE
function! g:Plugin_vim_SyntaxRange()
	function! g:TextEnableCodeSnip(filetype) abort
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

		let l:cmd = "call SyntaxRange#Include('" . l:pre . "', '" . l:post . "', '" . a:filetype . "', '" . l:match_group . "')"
		" echo l:cmd
		exec l:cmd
	endfunction

	function! s:_TextEnableCodeSnipAll()
		let l:langs = g:CommenterGetLanguages()
		for l:lang in l:langs
			call g:TextEnableCodeSnip(l:lang)
		endfor
	endfunction

	" au VimEnter * call s:_TextEnableCodeSnipAll()
endfunction

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

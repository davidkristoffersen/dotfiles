fu GeneralInit()
	" LAYOUT
	set tabpagemax=100		" Maximum #tabs
	set laststatus=2		" Always show status line
	set number				" Line numbers
	set relativenumber		" Relative line numbers
	set numberwidth=4		" Relative line numbers
	set wildmenu			" Command line completion

	" LINE WRAP
	set wrap linebreak		" Wrap word for word
	set formatoptions+=l	" Ensures word-wrap does not split words

	" HIGHLIGHT
	set nolist					" Do not print tab and eol characters
	syntax on					" Syntax highlighting
	let g:loaded_matchparen = 0	" Disable syntax matching () and {}
	let &t_SI = "\e[6 q"		" Cursor block in normal mode
	let &t_EI = "\e[2 q"		" Cursor vertical bar in insert mode

	" INDENT
	set tabstop=4			" #Spaces in tab character
	set softtabstop=0		" #Space in tab while editing
	set shiftwidth=4		" #Spaces in auto indent
	set shiftround			" Round indent to multiple of shiftwidth
	set autoindent			" Current indent is applied to the next
	set breakindent			" Current indent is applied to wrapeed line
	set nopaste				" If on: Pasting from other windows include indenting

	" SEARCH
	set hlsearch			" Highlight all matches
	set incsearch			" Instant highlight
	set ignorecase			" Ignore case
	set smartcase			" Use case when uppercase

	" EDIT
	set nofoldenable		" All folds are open
	set foldmethod=indent	" Lines with equal indent create a fold
	set backspace=2			" Backspace on indent, eol and start of insert
	set timeout				" Timeout on :mappings and key codes
	set ttimeoutlen=50		" Timeout in ms
	let g:mapleader = " "	" Leader set to space

	" NAVIGATE
	set splitright			" Open new file on the right
	set splitbelow			" Open new file below

	" UNDO
	set undofile				" Use an undo history file
	set undodir=$HOME/.vim/undo	" Undo file path
	set undolevels=1000			" Max #undo
	set undoreload=10000		" Max #lines in buffer to save for undo upon reload

	" OS
	set nocompatible			" Disable VI compatibility
	set encoding=utf-8			" Character encoding
	set noswapfile				" Do not generate swap file
	set shell=bash\ --login		" Execute bashrc aliases in ! mode
	set clipboard=unnamedplus	" Use both '+' and '*' register as clipboard
	set mouse=a					" Enable mouse in all modes

	" FILETYPE
	filetype on			" On edit: Do filetype detection
	filetype plugin on	" On edit: Load ftplugin files with matching filetype
	filetype indent on	" On edit: Load indent files with matching filetype
endf

call GeneralInit()

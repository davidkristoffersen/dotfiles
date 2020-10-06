" GENERAL
set nocompatible				" disable compatibility
set encoding=utf-8
filetype off
filetype plugin indent on		" file specific scripts
filetype plugin on		" file specific scripts
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
set rnu							" Relative line numbers

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

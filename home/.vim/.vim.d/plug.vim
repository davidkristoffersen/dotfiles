fu PlugInit()
	" Plug  plugins directory
	call plug#begin('~/.vim/plugged')

	" Fuzzy finder
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" Initialize plugin system
	call plug#end()
endf

call PlugInit()

fu PackInit()
	packadd ale
	packadd fzf
	packadd fzf.vim
	packadd git-blame.vim
	packadd i3config.vim
	" packadd nerdtree
	" packadd nerdtree-git-plugin
	" packadd omnisharp-vim
	packadd syntastic
	packadd tagbar
	packadd vim-SyntaxRange
	packadd vim-airline
	packadd vim-airline-themes
	packadd vim-commenter
	packadd vim-fugitive
	packadd vim-indent-guides
	packadd vim-ingo-library
	" packadd vim-javascript
	" packadd vim-jsx
	" packadd vim-nerdtree-tabs
	packadd vim-trailing-whitespace
	" packadd vimpager " WARNING: Very slow
endf

fu PluginsInit()
	call AleInit()
	call GitBlameInit()
	" call NERDtreeInit()
	" call OmnisharpInit()
	call SyntasticInit()
	call TagbarInit()
	call VimIndentGuidesInit()
	call VimSyntaxRangeInit()
	call VimTrailingWhiteSpaceInit()
	" call VimpagerInit()
endf

call PackInit()
call PluginsInit()

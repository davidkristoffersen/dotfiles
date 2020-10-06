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
" bash syntax exit error on startup

for f in split(glob($HOME . '/.vim/.vim.d/plugins/*.vim'), '\n')
	exe 'source' f
endfor

source $HOME/.vim/.vim.d/os.vim
source $HOME/.vim/.vim.d/pathogen.vim
source $HOME/.vim/.vim.d/general.vim
source $HOME/.vim/.vim.d/highlight.vim
source $HOME/.vim/.vim.d/commands.vim
source $HOME/.vim/.vim.d/map_mode.vim
source $HOME/.vim/.vim.d/map_leader.vim
source $HOME/.vim/.vim.d/practical.vim
source $HOME/.vim/.vim.d/functions.vim

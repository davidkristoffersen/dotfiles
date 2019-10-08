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

" GENERAL
set nocompatible				" disable compatibility
execute pathogen#infect()
set encoding=utf-8
filetype off
" filetype plugin indent on		" file specific scripts
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

" STATUS LINE
set laststatus=2		" always show status line

" SEARCH
set hlsearch			" highlight all matches
set incsearch			" instant highlight
set ignorecase			" ignore case
set smartcase			" use case when uppercase

" HARD TABS
set tabstop=4                       " tab width
set softtabstop=0 noexpandtab
set shiftwidth=4                    " shift width
set autoindent                      " auto indentation
set breakindent						" Indents word-wrapped lines as much as the 'parent' line
" Ensures word-wrap does not split words
set formatoptions=l
set lbr
au Filetype python setl et ts=4 sw=4 softtabstop=4

" UNDO HISTORY
set undofile                    " use an undo file
set undodir=$HOME/.vim/undo        " undo file path
set undolevels=1000
set undoreload=10000


" MAPS: MODE SPECIFIC
" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

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
noremap <leader>jj 20j
noremap <leader>kk 20k

" Remove soft tabs
nmap <leader>T :%s/\s\s\s\s/\t/g<cr>
" Remove hard tabs
nmap <leader>h :%s/\t/    /g<cr>

" Move tab next
nnoremap <leader>} :tabm +1<cr>
" Move tab prev
nnoremap <leader>{ :tabm -1<cr>
" Move tab next
nnoremap <leader>] :tabn<cr>
" Move tab prev
nnoremap <leader>[ :tabp<cr>

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
nnoremap <leader>iu :Silent        /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh u<cr>
" nnoremap <leader>iiu :Silent    /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh uu %<cr>
nnoremap <leader>iiu :call Upload()<cr>
nnoremap <leader>id :Silent        /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh d<cr>
nnoremap <leader>iid :Silent    /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh dd %<cr>
nnoremap <leader>is :Silent        /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh s<cr>
nnoremap <leader>ik :Silent        /home/david/studies/semester_6/inf_3910/inf_3910-project/scripts_mic/run.sh k<cr>

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
let g:toggles = {'set_paste':    [1, 'set paste', 'set nopaste'],
            \'set_number':    [1, 'set nonumber', 'set number'],
            \'spell_check':    [1, 'set nospell', 'set spell spelllang=en_us',],
            \'syntastic':    [1, 'SyntasticToggleMode', 'SyntasticToggleMode',],
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

" PLUGINS

" Syntastic
let g:syntastic_c_checkers = ['gcc', 'mpicc']

" NERDTree
" Open NERDTree when vim starts up
autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd l
let g:nerdtree_tabs_autofind=1
" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if only NERDTree is open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Leader map for opening NERDTree
nnoremap <leader>n :NERDTreeTabsToggle<CR>
" NERDTree will be on new tab
let g:nerdtree_tabs_open_on_console_startup=1
" Leader for navigating vimsplit
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
let NERDTreeIgnore = ['\.pyc$', '__pycache__$']
let NERDTreeWinSize = 20

" Vim git blame
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

" PinFold Make plugin! :)
"augroup pythonFold
"	autocmd!
"	autocmd BufReadPre *.py setlocal foldmethod=indent
"	autocmd CursorMovedI *.py call LightlineContext()
"	autocmd CursorMoved *.py call LightlineContext()
"augroup END
"
"function! PinFold()
"	" save current position
"	let saveCursor = getcurpos()
"	" Go to upper split, open all folds and go to the same line as bottom split
"	wincmd k
"	normal! zR
"	execute "normal! " . saveCursor[1] . "G"
"	" Go to the beginning of the fold and put the line top of the upper split
"	normal! [zkk
"	normal! zt
"	let contextline=getline('.')
"	" Go back to bottom split and restore position
"	wincmd j
"	call setpos('.', saveCursor)
"	return contextline
"endfunction
"
"function! LightlineContext()
"	return PinFold()
"endfunction

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239

let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1

" Tagbar
nmap <leader>t :TagbarToggle<CR>

" Vim trailing whitespace
nmap <leader>F :FixWhitespace<CR>

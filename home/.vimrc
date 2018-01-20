call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'myusuf3/numbers.vim'
Plug 'ervandew/supertab'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'moll/vim-node'
Plug 'tpope/vim-sensible'
Plug 'valloric/youcompleteme'
Plug 'derekwyatt/vim-scala'
Plug 'ktvoelker/sbt-vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'ensime/ensime-vim'
Plug 'vim-latex/vim-latex'

call plug#end()

set splitright
set splitbelow

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

augroup Defaults
	au!
	au BufWinEnter * set number
	au StdinReadPre * let s:std_in=1
	au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup end


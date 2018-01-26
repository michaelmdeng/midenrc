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

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax enable 

" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

set wildmenu
set wildmode=longest,list,full

" Height of the command bar
set cmdheight=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

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


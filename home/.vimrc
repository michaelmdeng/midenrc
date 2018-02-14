call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-scala'
Plug 'elzr/vim-json'
Plug 'ensime/ensime-vim'
Plug 'ervandew/supertab'
Plug 'ktvoelker/sbt-vim'
Plug 'moll/vim-node'
Plug 'myusuf3/numbers.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'scrooloose/nerdtree'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-latex/vim-latex'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vimwiki/vimwiki'

call plug#end()

" to be safe
set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

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

" get <C-j> to work
let g:BASH_Ctrl_j = 'off'
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" persistent undo
try
	set undodir=~/.vim/temp/undo
	set undofile
catch
endtry

" NERDTree specific config
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" vimwiki specific config
let g:vimwiki_list = [{'path':'~/vimwiki/wiki', 'path_html':'~/vimwiki/html/'}]

" syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

augroup Defaults
	au!
	au BufWinEnter * set number
	au StdinReadPre * let s:std_in=1
	au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup end


" VimPlug stuff
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ajmwagar/vim-deus'
Plug 'altercation/vim-colors-solarized'
Plug 'cazador481/fakeclip.neovim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'ensime/ensime-vim'
Plug 'ervandew/supertab'
Plug 'haya14busa/incsearch.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ktvoelker/sbt-vim'
Plug 'moll/vim-node'
Plug 'myusuf3/numbers.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'scrooloose/nerdtree'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-latex/vim-latex'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vimwiki/vimwiki'
Plug 'Yggdroot/indentLine'
call plug#end()

" to be safe
set nocompatible

" colorscheme
set background=dark
colorscheme deus

" Enable filetype plugins
filetype plugin on
filetype indent on

" Remove backup
set nobackup
set noswapfile

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
set wildmode=longest,list
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows

" Height of the command bar
set cmdheight=2

" Ignore case when searching
" When searching try to be smart about cases
set ignorecase
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

" Window split settings
set splitright
set splitbelow

" number settings
set number
set relativenumber

" get <C-j> to work
let g:BASH_Ctrl_j = 'off'
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>

" persistent undo
try
	set undodir=~/.vim/temp/undo
	set undofile
catch
endtry

" leader<o> and leader<CR> for inserting lines without entering insert mode
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>
nmap <leader><CR> o<Esc>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Insert mode shortcut
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" Command mode shortcut
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
" Move to the start of line
nnoremap H ^
vnoremap H ^
" Move to the end of line
nnoremap L $
vnoremap L $
" D to line ends
nnoremap dH d^
nnoremap dL d$
" Y to line ends
nnoremap yH y^
nnoremap yL y$

cnoremap <C-d> <Delete>
" NERDTree specific config
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 1

" vimwiki specific config
let g:vimwiki_list = [{'path':'~/Dropbox/Personal/vimwiki/wiki', 'path_html':'~/Dropbox/Personal/vimwiki/html/'}]

" syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Editorconfig config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Rainbow Parens
augroup RainbowParens
	au VimEnter * RainbowParenthesesActivate
	au Syntax * RainbowParenthesesLoadRound
	au Syntax * RainbowParenthesesLoadSquare
	au Syntax * RainbowParenthesesLoadBraces
augroup end

" GitGutter
nmap <leader>nh :GitGutterNextHunk<CR>
nmap <leader>ph :GitGutterPrevHunk<CR>
nmap <leader>sh :GitGutterStageHunk<CR>
nmap <leader>uh :GitGutterUndoHunk<CR>

"fake clip
let g:vim_fakeclip_tmux_plus=1

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_custom_ignore = {
  \ 'file': '\v(\.cpp|\.h|\.hh|\.cxx)@<!$'
  \ }
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
map <Tab> <Over>(incsearch-next)
map <S-Tab> <Over>(incsearch-prev)

augroup indentLine
	au BufEnter * IndentLinesEnable
augroup end

let g:vim_json_syntax_conceal = 0

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

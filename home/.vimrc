" VimPlug stuff
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ajmwagar/vim-deus'
Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/csv.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'ensime/ensime-vim'
Plug 'ervandew/supertab'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ktvoelker/sbt-vim'
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
nmap <C-s> :w<cr>
nmap <leader>w :w<cr>
nmap <leader>W :W<cr>

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
map gb :bnext<cr>
map gB :bprevious<cr>

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

" airline
let g:airline#extensions#hunks#enabled=0
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v'

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-scala
let g:scala_sort_across_groups=1
let g:scala_user_default_keymappings=0

" fzf
nmap <C-p> :GFiles<cr> 
nmap <C-f> :Rg<cr> 
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~20%' }
" add command for ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:20%:hidden', '?'),
  \   <bang>0)

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

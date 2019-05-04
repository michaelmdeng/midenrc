" VimPlug stuff
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ajmwagar/vim-deus'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/csv.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ktvoelker/sbt-vim'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'mhartington/oceanic-next'
Plug 'michaelmdeng/ensime-vim', { 'branch': 'miden/master' , 'do': ':UpdateRemotePlugins' }
Plug 'myusuf3/numbers.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'neomake/neomake'
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'roxma/vim-tmux-clipboard'
Plug 'scrooloose/nerdtree'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/indentpython.vim'
Plug 'vimwiki/vimwiki'
Plug 'zchee/deoplete-jedi'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" to be safe
set nocompatible

" colorscheme
if !has('gui_running')
  set t_Co=256
endif

if (has("termguicolors"))
  set termguicolors
endif

set background=dark

colorscheme OceanicNext

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
command! W w !sudo tee % > /dev/null
nmap <C-s> :w<cr>
nmap <C-a> ggvG$
nmap <leader>w :w<cr>
nmap <leader>a ggvG$

set wildmenu
set wildmode=longest,list
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows

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

" update quickly
set updatetime=500

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
inoremap <C-b> <BS>
inoremap <C-d> <Del>
" Command mode shortcut
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-b> <BS>
cnoremap <C-d> <Del>
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
" window resize shortcuts
nnoremap <C-w>+ :res +5<CR>
nnoremap <C-w>- :res -5<CR>
nnoremap <C-w>> :vert res +5<CR>
nnoremap <C-w>< :vert res -5<CR>
" insert/normal cursor
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
" maintain folds
autocmd InsertLeave,WinEnter * let &l:foldmethod=g:oldfoldmethod
autocmd InsertEnter,WinLeave * let g:oldfoldmethod=&l:foldmethod | setlocal foldmethod=manual

set listchars=eol:$,tab:->,trail:~,extends:>,precedes:<,space:␣

" ctags stuff
set tags=./tags;,tags;
map <leader><leader>* :!ctags -R -f ./.git/tags .<cr><cr>

" always show SignColumn
set signcolumn=yes

" more cmd
set cmdheight=2

" customize completion menu
set completeopt="menu,noinsert,noselect"

set shortmess+=c

" we have a statusline
set noshowmode

set timeoutlen=300

" NERDTree specific config
let NERDTreeDirArrows = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeMouseMode = 2
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 1

" vimwiki specific config
au FileType vimwiki set filetype=vimwiki.markdown
let g:vimwiki_list = [{
\ 'path':'~/Dropbox/vimwiki/wiki',
\ 'path_html':'~/Dropbox/vimwiki/html/',
\ 'syntax': 'markdown',
\ 'ext': '.md',
\ 'auto_tags': 1,
\ 'auto_toc': 1
\ }]
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_conceallevel=0
let g:vimwiki_folding='expr:quick'

" syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint', 'python', 'pep8']
let g:syntastic_scala_checkers = ['ensime']

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
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
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

" lightline
let g:lightline = {
\ 'colorscheme': 'seoul256',
\ 'active': {
\   'left': [
\     ['mode', 'paste', 'spell'],
\     ['readonly', 'modified', 'gitbranch'],
\     ['relativepath']
\   ],
\   'right': [
\     ['lineinfo'],
\     [ 'fileformat', 'fileencoding', 'filetype']
\   ]
\ },
\ 'component_function': {
\   'gitbranch': 'LightGitbranch',
\   'fileformat': 'LightFileformat',
\   'filetype': 'LightFiletype' }
\ }

function! LightGitbranch()
  return winwidth(0) > 100 ? fugitive#head() : ''
endfunction

function! LightFiletype()
  return winwidth(0) > 80 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-scala
let g:scala_scaladoc_indent = 1
let g:scala_sort_across_groups=1
let g:scala_use_default_keymappings = 0
let g:scala_user_default_keymappings=0

" fzf
nmap <C-p> :GFiles<cr>
nmap <leader>p :Files<cr>
nmap <C-f> :Rg<cr>
nmap <leader>* :Tags<cr>

let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit' 
\ }

let g:fzf_layout = { 'down': '~20%' }

" add command for ripgrep
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:20%:hidden', '?'),
\   <bang>0)

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips']
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala = '[^. *\t]\.\w*'

" ultisnips
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/ultisnips']
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsJumpBackwardTrigger = '<c-p>'
let g:UltiSnipsJumpForwardTrigger = '<c-n>'

" neomake
call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['pylint']

" vim-markdown
let g:vim_markdown_conceal = 0

nmap <leader>pf :set nonu nornu <bar> GitGutterSignsDisable <bar> IndentLinesDisable<CR>
nmap <leader>fp :set nu rnu <bar> GitGutterSignsEnable <bar> IndentLinesEnable<CR>

" CoC settings

nmap <C-r>r <Plug>(coc-rename)
nmap <leader>t :call CocAction('doHover')<CR>
nmap <leader>df <Plug>(coc-definition)
nmap <leader>rs <Plug>(coc-references)
nmap <leader>oo :<C-u>CocList outline<cr>

autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" personal plugin

function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

" VimPlug stuff
call plug#begin('~/.vim/plugged')
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'ajmwagar/vim-deus'
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
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mhartington/oceanic-next'
Plug 'michaelmdeng/miden-vim'
Plug 'myusuf3/numbers.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'tpope/vim-vinegar'
Plug 'vimwiki/vimwiki'
call plug#end()

" ---------
" Settings
" ---------

set nocompatible

" Color stuff
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

" Space leader
let mapleader = " "
let g:mapleader = " "

syntax enable

" Auto read when a file is changed from the outside
set autoread

" Wild menu settings
" Works like the shell
set wildmenu
set wildmode=longest,list
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*.o,*.obj,*.so     " Unix
set wildignore+=*.exe            " Windows

" Case settings for search
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Regex stuff
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Window split settings
set splitright
set splitbelow

" Line number settings
set number
set relativenumber

" always show SignColumn
set signcolumn=yes

" Persistent undo
try
        set undodir=~/.vim/temp/undo
        set undofile
catch
endtry

" How to display whitespace
set listchars=eol:$,tab:->,trail:~,extends:>,precedes:<,space:␣

" Ctags file
set tags=./tags;,tags;

" we have a statusline
set noshowmode

" Update CursorHold quickly
set updatetime=500

" Faster timeout for command sequences
set timeoutlen=300

" More cmd bar
set cmdheight=2

" Customize completion menu
set completeopt="menu,noinsert,noselect"

" Ignore some messages
set shortmess+=c

" ---------
" Mappings
" ---------

" Windows mappings
nmap <C-a> ggvG$
nmap <C-s> :w<cr>

" window resize shortcuts
nnoremap <C-w>+ :res +5<CR>
nnoremap <C-w>- :res -5<CR>
nnoremap <C-w>> :vert res +5<CR>
nnoremap <C-w>< :vert res -5<CR>

" leader<o> and leader<CR> for inserting lines without entering insert mode
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>

" Move within visual lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

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

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Generate ctags quickly
nnoremap <leader><leader>* :!ctags -R -f ./.git/tags .<cr><cr>

" Bubble lines up and down
nmap <C-Up> :m .-2<CR>
nmap <C-Down> :m .+1<CR>
vnoremap <silent> <C-Up> @='"zxk"zP`[V`]'<CR>
vnoremap <silent> <C-Down> @='"zx"zp`[V`]'<CR>

" Insert mode movements
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-b> <BS>
inoremap <C-d> <Del>

" Command mode movements
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-b> <BS>
cnoremap <C-d> <Del>

" Close list windows
nmap <leader>cl :windo lcl<bar>ccl<CR>:windo lcl<bar>ccl<CR>

" GTFO Ex mode
nnoremap Q <Nop>

nmap <leader>ve :VimrcEdit<cr>
nmap <leader>vr :VimrcReload<cr>

" Previous/next mappings
" jumps
nnoremap [j <C-o>
nnoremap ]j <C-i>
" changes handled by GitGutter
" quickfix
nnoremap [q :cp<CR>
nnoremap ]q :cn<CR>
nnoremap [Q :cfir<CR>
nnoremap ]Q :cla<CR>
" locations
nnoremap [l :lp<CR>
nnoremap ]l :lne<CR>
nnoremap [L :lfir<CR>
nnoremap ]L :lla<CR>
" tagstack
nnoremap [t <C-t>
nnoremap ]t :tag<CR>
" buffers
nmap [b :bprevious<cr>
nmap ]b :bnext<cr>
nmap [B :bfirst<cr>
nmap ]B :blast<cr>
" tab page
nmap [p :tablast<cr>
nmap ]p :tabN<cr>
nmap [P :tabfirst<cr>
nmap ]P :tablast<cr>


" ---------
" Autocmds
" ---------

" insert/normal cursor
augroup InsertCursor
  autocmd InsertEnter * set cul
  autocmd InsertLeave * set nocul
augroup end

" maintain folds
augroup MaintainFolds
  autocmd InsertLeave,WinEnter * let &l:foldmethod=g:oldfoldmethod
  autocmd InsertEnter,WinLeave * let g:oldfoldmethod=&l:foldmethod | setlocal foldmethod=manual
augroup end

" --------------
" Plugin Config
" --------------

" Vim-tmux-navigator
let g:BASH_Ctrl_j = 'off'

" Vimwiki specific config
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
let g:vimwiki_table_mappings=0

" Syntastic config
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
nmap <leader>sh :GitGutterStageHunk<CR>
nmap <leader>uh :GitGutterUndoHunk<CR>

" Incsearch
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

" IndentLines config
augroup indentLine
        au BufEnter * IndentLinesEnable
augroup end

" vim-json config
let g:vim_json_syntax_conceal = 0

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
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
"
" Customize fzf colors to match your color scheme
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment']
\ }

" ultisnips
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/ultisnips']
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsExpandTrigger="<m-q>"
let g:UltiSnipsJumpBackwardTrigger = '<c-p>'
let g:UltiSnipsJumpForwardTrigger = '<c-n>'

" neomake
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['pylint', 'airflow']
let g:neomake_python_airflow_maker = {
\ 'exe': '/Users/michaeldeng/.virtualenvs/airflow/bin/pylint',
\ 'args': ['--output-format=text', '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"', '--reports=no'],
\ 'errorformat': '%A%f:%l:%c:%t: %m,%A%f:%l: %m,%A%f:(%l): %m,%-Z%p^%.%#,%-G%.%#'
\ }

" vim-markdown
let g:vim_markdown_conceal = 0

nmap <leader>pf :set nonu nornu scl=no <bar> GitGutterSignsDisable <bar> IndentLinesDisable<CR>
nmap <leader>fp :set nu rnu scl=yes <bar> GitGutterSignsEnable <bar> IndentLinesEnable<CR>

" CoC settings

nmap <C-r>r <Plug>(coc-rename)
nmap <leader>df <Plug>(coc-definition)
nmap <leader>dfs :call CocAction('jumpDefinition', 'split')<CR>
nmap <leader>dfv :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <leader>rs <Plug>(coc-references)
nmap <leader>t :call CocAction('doHover')<CR>
nmap <leader>cc :CocCommand<CR>
nmap <leader>ci :CocList<CR>
nmap <leader>ca :CocAction<CR>

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Undotree
let g:undotree_SplitWidth = 35
let g:undotree_DiffpanelHeight = 15
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_RelativeTimestamp = 1
let g:undotree_ShortIndicators = 1

" Netwr settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Nerdtree settings
let NERDTreeDirArrows = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeMouseMode = 2
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeShowLineNumbers = 1
let NERDTreeMapOpenSplit='gs'
let NERDTreeMapOpenVSplit='gv'
let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''
nnoremap gp :NERDTreeToggle<CR>

" -----------------
" Custom Functions
" -----------------

" :W sudo saves the file
command! W w !sudo tee % > /dev/null

" Command for ripgrep
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:20%:hidden', '?'),
\   <bang>0)

" Command to show trailing whitespace
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

command! -bar -nargs=0 VimrcEdit :vs ~/.vimrc
command! -bar -nargs=0 VimrcReload :so $MYVIMRC
nnoremap <leader>ve :VimrcEdit<CR>
nnoremap <leader>vr :VimrcReload<CR>

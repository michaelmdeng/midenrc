call plug#begin('~/.vim/plugged')

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'SirVer/ultisnips'
Plug 'ajmwagar/vim-deus'
Plug 'altercation/vim-colors-solarized'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'chrisbra/csv.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'isRuslan/vim-es6'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kien/rainbow_parentheses.vim'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mhartington/oceanic-next'
Plug 'michaeljsmith/vim-indent-object'
Plug 'michaelmdeng/miden-vim', {'branch': 'master', 'do': ':UpdateRemotePlugins'}
Plug 'myusuf3/numbers.vim'
Plug 'neomake/neomake'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'rhysd/vim-grammarous'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki'
Plug 'voldikss/vim-floaterm'

if has('nvim')
  Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'ncm2/float-preview.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

call plug#end()

" ---------
" Settings
" ---------

" Color stuff
if !has('gui_running')
  set t_Co=256
endif

if (has("termguicolors"))
  set termguicolors
endif

syntax enable

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme nightfly

" Enable filetype plugins
filetype plugin on
filetype indent on

" Remove swap
set noswapfile

" Space leader
let mapleader = " "
let g:mapleader = " "

" Auto read when a file is changed from the outside
set autoread

" Wild menu settings
set wildmode=longest,list
set wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*.o,*.obj,*.so     " Unix
set wildignore+=*.exe            " Windows

" Case settings for search
set ignorecase

" Don't redraw while executing macros (good performance config)
set lazyredraw

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
set undofile

" How to display whitespace
set listchars=eol:$,tab:->,trail:~,extends:>,precedes:<,space:␣

" Ctags file
set tags=./tags,tags;$HOME

" we have a statusline
set noshowmode

" Update CursorHold quickly
set updatetime=500

" Faster timeout for command sequences
set timeoutlen=500

" More cmd bar
set cmdheight=2

" Customize completion menu
set completeopt=menuone,noinsert,noselect

" Ignore some messages
set shortmess+=c

set viewoptions-=options

set nojoinspaces

set scrolloff=3

" ---------
" Mappings
" ---------

" Windows mappings
nmap <C-a> gg0vG$
nmap <C-s> :w<cr>

" window resize shortcuts
nnoremap <C-w>+ :res +5<CR>
nnoremap <C-w>- :res -5<CR>
nnoremap <C-w>> :vert res +5<CR>
nnoremap <C-w>< :vert res -5<CR>

" Insert lines without entering insert mode
nmap <leader>o o<Esc>k
nmap <leader>O O<Esc>j

" Move within visual lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

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

" Visual shifting
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
cnoremap <C-l> <Right>
cnoremap <C-b> <BS>
cnoremap <C-d> <Del>

" Restore digraph
inoremap <C-q> <C-k>

" Close list windows
nmap <leader>cl :windo lcl<bar>ccl<CR>:windo lcl<bar>ccl<CR>

nmap <leader>ve :VimrcEdit<cr>
nmap <leader>vr :VimrcReload<cr>

" Previous/next mappings
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
nmap ]p :tabnext<cr>
nmap [P :tabfirst<cr>
nmap ]P :tablast<cr>

" Esc for term mode
tnoremap <Esc><Esc> <C-\><C-n>

" Split tags
nnoremap <C-s>] <C-w>]
nnoremap <C-v>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" very-magic search
nnoremap / /\V
nnoremap ? ?\V
vnoremap / /\V
vnoremap ? ?\V

" delete without clobbering registers
nnoremap s "_d
nnoremap S "_D
nnoremap ss "_dd

" GTFO Ex mode
nnoremap Q @@

" yank-quit
nnoremap <leader>yq gg0vG$"+y:q!<cr>

" more natural paragraphs
nnoremap <silent> } :call search('\(^$\n\s*\zs\S\)\<bar>\(\S\ze\n*\%$\)', 'sW')<CR>
nnoremap <silent> { :call search('\(^$\n\s*\zs\S\)\<bar>\(^\%1l\s*\zs\S\)','sWb')<CR>

nnoremap <leader><C-u> mp<C-u>`p
nnoremap <leader><C-d> mp<C-d>`p

" ---------
" Autocmds
" ---------

" insert/normal cursor
augroup InsertCursor
  autocmd InsertEnter * set cul
  autocmd InsertLeave * set nocul
augroup end

" maintain folds
augroup MaintainFoldMethod
  autocmd BufWrite * mkview!
  autocmd BufRead * silent! loadview
augroup end

" --------------
" Plugin Config
" --------------

" Vim-tmux-navigator
let g:BASH_Ctrl_j = 'off'

" Vimwiki
au FileType vimwiki set filetype=markdown
let g:vimwiki_list = [{
\ 'path':'~/Dropbox/vimwiki/wiki',
\ 'path_html':'~/Dropbox/vimwiki/html/',
\ 'syntax': 'markdown',
\ 'ext': '.md',
\ 'auto_tags': 1,
\ 'auto_toc': 1,
\ 'custom_wiki2html': '~/.scripts/vimwiki-pandoc.py'
\ }]
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_conceallevel=0
let g:vimwiki_folding='expr:quick'
let g:vimwiki_table_mappings=0

function! BetterVimwikiDiaryGenerateLinks()
  VimwikiDiaryGenerateLinks
  :%s/\s\+\*/*/e
  :%s/\(#\+\s.\+$\)/\1\r/e
  :%s/\n\{3,}/\r\r/e
endfunction

" vim-editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" rainbow_parentheses
augroup RainbowParens
  au VimEnter * RainbowParenthesesActivate
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
augroup end

" Incsearch and vim-asterisk
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#do_not_save_error_message_history = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map g* <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map #  <Plug>(incsearch-nohl)<Plug>(asterisk-#)
map g# <Plug>(incsearch-nohl)<Plug>(asterisk-g#)

" IndentLines config
augroup indentLine
  au BufEnter * IndentBlanklineEnable
augroup end
let g:indent_blankline_space_char = ' '
let g:indent_blankline_show_current_context = 1
let g:indent_blankline_show_current_context_start = 1

" vim-json config
let g:vim_json_syntax_conceal = 0

" Lightline
let g:lightline = {
\ 'colorscheme': 'nightfly',
\ 'active': {
\   'left': [
\     ['mode', 'paste', 'spell'],
\     ['readonly', 'lightmodified', 'lightgitbranch'],
\     ['lightrelpath']
\   ],
\   'right': [
\     ['lineinfo'],
\     ['lightfiletype'],
\   ]
\ },
\ 'inactive': {
\   'left': [
\     ['lightgitbranch', 'lightrelpath']
\   ],
\   'right': [
\     ['lineinfo'],
\     ['lightfiletype']
\   ]
\ },
\ 'component_function': {
\   'lightmodified': 'LightModified',
\   'lightgitbranch': 'LightGitBranch',
\   'lightrelpath': 'LightRelPath',
\   'lightfiletype': 'LightFileType'
\   }
\ }

function! LightModified()
  return &modifiable && &modified ? '+' : ''
endfunction

function! LightGitBranch()
  let head = fugitive#head()
  return (winwidth(0) - strlen(head)) > 75 ? head : '...' . head[strlen(head) - 10:]
endfunction

function! LightRelPath()
  let relpath = expand('%')
  return (winwidth(0) - strlen(relpath)) > 50 ? expand('%') : pathshorten(expand('%'))
endfunction

function! LightFileType()
  return winwidth(0) > 100 && &fileformat !=# '' ? &filetype : ''
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
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

function! HasGit()
  let tmp = system('git rev-parse')
  return !v:shell_error
endfunction

nnoremap <expr> <C-p> HasGit() ? ":GFiles<CR>" : ":Files<CR>"
nmap <leader>p :Files<cr>
nmap <leader><C-p> :History<cr>
nmap <C-f> :Rg<cr>
nmap <leader>* :Tags<cr>
nmap <leader>: :Commands<cr>

let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit' 
\ }

let g:fzf_layout = { 'down': '~30%' }
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
let g:UltiSnipsJumpBackwardTrigger = '<c-p>'
let g:UltiSnipsJumpForwardTrigger = '<c-n>'
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

" neomake
let g:neomake_open_list = 2
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_markdown_enabled_makers = ['mdl']
cnoreabbrev make Neomake
nnoremap <leader><leader>= :Neomake<CR>

" Undotree
let g:undotree_SplitWidth = 35
let g:undotree_DiffpanelHeight = 15
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_RelativeTimestamp = 1
let g:undotree_ShortIndicators = 1
nnoremap <leader>uu :UndotreeToggle<CR>

" Netwr settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_bufsettings = "noma nomod nobl nowrap ro nu rnu"

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

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" float-preview.nvim
let g:float_preview#docked = 0

" firenvim
let g:firenvim_config = {
\   'globalSettings': {
\     'cmdline': 'workon nvim3 && nvim',
\     'priority': 0,
\     'selector': 'textarea',
\     'takeover': 'never',
\    },
\   'localSettings': {
\     '.*': {
\       'cmdline': 'workon nvim3 && nvim',
\       'priority': 0,
\       'selector': 'textarea',
\       'takeover': 'never',
\     },
\   }
\ }

" grammarous
let g:grammarous#use_vim_spelllang = 1
let g:grammarous#use_location_list = 1

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 150
let g:qs_buftype_blacklist = ['terminal', 'nofile', 'fzf', 'netrw']
let g:qs_second_highlight = 0
let g:qs_lazy_highlight = 1

" vim-tex
let g:tex_flavor = 'latex'

" wilder.nvim
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({
\ 'highlighter': wilder#basic_highlighter(),
\ }))

" -----------------
" Custom Functions
" -----------------

" :W sudo saves the file
command! W w !sudo tee % > /dev/null

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

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

function! EditFile(file, mode)
  if a:mode == 'e'
    exec 'e' . a:file
  elseif a:mode == 's'
    exec 'sp' . a:file
  else
    exec 'vs' . a:file
  end
endfunction

command! -bar -nargs=1 FtpluginEdit call EditFile('~/.vim/ftplugin/' . &filetype . '.vim', <q-args>)
nnoremap <silent> <leader>fte :FtpluginEdit e<CR>
nnoremap <silent> <leader>fts :FtpluginEdit s<CR>
nnoremap <silent> <leader>ftv :FtpluginEdit v<CR>

command! -bar -nargs=1 VimrcEdit call EditFile('~/.vimrc', <q-args>)
nnoremap <silent> <leader>vre :VimrcEdit e<CR>
nnoremap <silent> <leader>vrs :VimrcEdit s<CR>
nnoremap <silent> <leader>vrv :VimrcEdit v<CR>

command! -bar -nargs=0 VimrcReload :so $MYVIMRC
nnoremap <silent> <leader>vrr :VimrcReload<CR>

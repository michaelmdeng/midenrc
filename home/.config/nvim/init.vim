let g:python_host_prog="~/.virtualenvs/nvim2/bin/python"
let g:python3_host_prog="~/.virtualenvs/nvim3/bin/python"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Cmd preview
set inccommand=nosplit

" Nvim LSP
if executable('bash-language-server')
lua << EOF
require'lspconfig'.bashls.setup{}
EOF
endif
if executable('css-languageserver')
lua << EOF
require'lspconfig'.cssls.setup{}
EOF
endif
if executable('docker-langserver')
lua << EOF
require'lspconfig'.dockerls.setup{}
EOF
endif
if executable('gopls')
lua << EOF
require'lspconfig'.gopls.setup{}
EOF
endif
if executable('html-languageserver')
lua << EOF
require'lspconfig'.html.setup{}
EOF
endif
if executable('pyls')
lua << EOF
require'lspconfig'.pyls.setup{}
EOF
endif
if executable('solargraph')
lua << EOF
require'lspconfig'.solargraph.setup{}
EOF
endif
if executable('terraform-ls')
lua << EOF
require'lspconfig'.terraformls.setup{}
EOF
endif
if executable('vim-language-server')
lua << EOF
require'lspconfig'.vimls.setup{}
EOF
endif
if executable('yamlls')
lua << EOF
require'lspconfig'.yamlls.setup{}
EOF
endif

function! HasLsp()
  return luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients())')
endfunction

function! SetupLsp() abort
  setlocal omnifunc=v:lua.vim.lsp.omnifunc

  nnoremap <buffer><silent> <leader>t  <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <buffer><silent> <leader>dc <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <buffer><silent> <leader>df <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <buffer><silent> <leader>sg <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <buffer><silent> <leader>rf <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <buffer><silent> <c-r>r <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <buffer><silent> <leader>= <cmd>lua vim.lsp.buf.formatting()<CR>
  nnoremap <buffer><silent><expr> <c-]> ":lua vim.lsp.buf.definition()<CR>"
endfunction

" Treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader><Right>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader><Left>"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[A"] = "@parameter.inner",
      },
    },
  },
}
EOF
" Nvim LSP
if executable('bash-language-server')
lua << EOF
require'lspconfig'.bashls.setup{}
EOF
endif
if executable('css-languageserver')
lua << EOF
require'lspconfig'.cssls.setup{}
EOF
endif
if executable('docker-langserver')
lua << EOF
require'lspconfig'.dockerls.setup{}
EOF
endif
if executable('gopls')
lua << EOF
require'lspconfig'.gopls.setup{}
EOF
endif
if executable('html-languageserver')
lua << EOF
require'lspconfig'.html.setup{}
EOF
endif
if executable('pyls')
lua << EOF
require'lspconfig'.pyls.setup{}
EOF
endif
if executable('solargraph')
lua << EOF
require'lspconfig'.solargraph.setup{}
EOF
endif
if executable('terraform-ls')
lua << EOF
require'lspconfig'.terraformls.setup{}
EOF
endif
if executable('vim-language-server')
lua << EOF
require'lspconfig'.vimls.setup{}
EOF
endif
if executable('yamlls')
lua << EOF
require'lspconfig'.yamlls.setup{}
EOF
endif

let g:python_host_prog="~/.virtualenvs/nvim2/bin/python"
let g:python3_host_prog="~/.virtualenvs/nvim3/bin/python"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Cmd preview
set inccommand=nosplit

" Treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed={
    "bash",
    "comment",
    "css",
    "dockerfile",
    "go",
    "graphql",
    "hcl",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "kotlin",
    "latex",
    "lua",
    "make",
    "markdown",
    "python",
    "regex",
    "ruby",
    "scala",
    "toml",
    "typescript",
    "vim",
    "yaml"
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ak"] = "@block.outer",
        ["ik"] = "@block.inner",
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
        ["]k"] = "@block.outer",
        ["]f"] = "@function.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]K"] = "@block.outer",
        ["]F"] = "@function.outer",
        ["]A"] = "@parameter.outer",
      },
      goto_previous_start = {
        ["[k"] = "@block.outer",
        ["[f"] = "@function.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[K"] = "@block.outer",
        ["[F"] = "@function.outer",
        ["[A"] = "@parameter.outer",
      },
    },
  },
}
EOF

" gitsigns
lua << EOF
  require('gitsigns').setup {
    keymaps = {
      noremap = true,
        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},
        ['n <leader>sh'] = '<cmd>Gitsigns stage_hunk<CR>',
        ['n <leader>uh'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
        ['n <leader>rh'] = ':Gitsigns reset_hunk<CR>',
        ['v <leader>rh'] = ':Gitsigns reset_hunk<CR>',
        ['n <leader>bh'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
        ['n <leader>ph'] = '<cmd>Gitsigns preview_hunk<CR>',
        ['n <leader>Sh'] = '<cmd>Gitsigns stage_buffer<CR>',
        ['n <leader>Uh'] = '<cmd>Gitsigns reset_buffer_index<CR>',
        ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
        ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    }
  }
EOF

nnoremap <leader>pf :set nonu nornu scl=no <bar> :luado require('gitsigns').toggle_signs() <bar> IndentBlanklineDisable<CR>
nnoremap <leader>fp :set nu rnu scl=yes <bar> :luado require('gitsigns').toggle_signs() <bar> IndentBlanklineEnable<CR>
nnoremap <leader>hh :luado require('gitsigns').setloclist(0)<CR>

" Nvim LSP
lua << EOF
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  -- buffer
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>dc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>df', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>im', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<c-r>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>sg', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>Df', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- diagnostics
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>dd', '<cmd>lua vim.lsp.diagnostic.setloclist()<CR>', opts)
end

local nvim_lsp = require('lspconfig')
local servers = {
  bashls = 'bash-language-server',
  cssls = 'css-languageserver',
  dockerls = 'docker-langserver',
  gopls = 'gopls',
  html = 'html-languageserver',
  pylsp = 'pyls',
  solargraph = 'solargraph',
  terraformls = 'terraform-ls',
  vimls = 'vim-language-server',
  yamlls = 'yamlls'
}
for lsp, exec in pairs(servers) do
  local cmd = string.format('executable(\'%s\')', exec)
  if (vim.api.nvim_eval(cmd))
  then
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
end
EOF

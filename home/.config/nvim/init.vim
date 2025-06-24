let g:python_host_prog="~/.virtualenvs/nvim2/bin/python"
let g:python3_host_prog="~/.virtualenvs/nvim3/bin/python"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Cmd preview
set inccommand=nosplit

" Global status line
set laststatus=3

" Improved filetype detection
let g:do_filetype_lua = 1

lua << EOF
require('md-treesitter')
EOF

" gitsigns
lua << EOF
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})
      -- Stage
      map('n', '<leader>sh', gs.stage_hunk)
      map('v', '<leader>sh', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('n', '<leader>Sh', gs.stage_buffer)
      map('v', '<leader>Sh', gs.stage_buffer)
      -- Restore (undo stage)
      map('n', '<leader>rh', gs.undo_stage_hunk)
      map('v', '<leader>rh', function() gs.undo_stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      -- Undo (reset)
      map('n', '<leader>uh', gs.reset_hunk)
      map('v', '<leader>hh', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('n', '<leader>Uh', gs.reset_buffer_index)
      -- Misc
      map('n', '<leader>bh', function() gs.blame_line{full=true} end)
      map('n', '<leader>ph', gs.preview_hunk)
      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
EOF

nnoremap <leader>pf :set nonu nornu scl=no <bar> luado require('gitsigns').toggle_signs() <bar> IndentBlanklineDisable<CR>
nnoremap <leader>fp :set nu rnu scl=yes <bar> luado require('gitsigns').toggle_signs() <bar> IndentBlanklineEnable<CR>
nnoremap <leader>hh :luado require('gitsigns').setloclist(0)<CR>

" Nvim LSP
lua << EOF
require('md-lsp')
EOF

" nvim-cmp
lua << EOF
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local cmp = require('cmp')
cmp.setup {
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
    },
    {
      { name = 'buffer' },
    }
  ),
  preselect = cmp.PreselectMode.Item,
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping.abort(),
  },
}

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
EOF

" nvim-telescope
lua << EOF
require('md-telescope')

vim.cmd.amenu([[PopUp.Rename <Cmd>lua vim.lsp.buf.rename()<CR>]])
vim.cmd.amenu([[PopUp.Format <Cmd>lua vim.lsp.buf.formatting()<CR>]])
vim.cmd.amenu([[PopUp.Go-to\ Definition <Cmd>Telescope lsp_definitions<CR>]])
vim.cmd.amenu([[PopUp.Implementations <Cmd>Telescope lsp_implementations<CR>]])
vim.cmd.amenu([[PopUp.References <Cmd>Telescope lsp_references<CR>]])
vim.cmd.amenu([[PopUp.Code\ Action <Cmd>lua vim.lsp.buf.code_action()<CR>]])
vim.cmd.amenu([[PopUp.-SEP1- <cmd>]])
vim.cmd.amenu([[PopUp.GitFiles <Cmd>Telescope git_files<CR>]])
vim.cmd.amenu([[PopUp.Files <Cmd>lua require"telescope.builtin".find_files()<CR>]])
vim.cmd.amenu([[PopUp.Recent\Files <Cmd>Telescope old_files<CR>]])
EOF

" nvim-dap
lua << EOF
local dap = require("dap")
require('dap-go').setup()
require('dap-python').setup()
require('dap-ruby').setup()

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

local metals_config = require("metals").bare_config()
metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.cmd.amenu([[PopUp.-SEP2- <cmd>]])
vim.cmd.amenu([[PopUp.Debug <Cmd>lua require'dap'.continue()<CR>]])
vim.cmd.amenu([[PopUp.Toggle\ Breakpoint <Cmd>lua require'dap'.toggle_breakpoint()<CR>]])
EOF

nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F9> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>

" indent-blankline
augroup indentLine
  au BufEnter * IndentBlanklineEnable
augroup end

let g:indent_blankline_space_char = ' '
let g:indent_blankline_show_current_context = 1
let g:indent_blankline_show_current_context_start = 1

" nvim-tree
lua require('md-nvim-tree')

lua << EOF
require("nvim-lightbulb").setup({
  sign = { enabled = false },
  virtual_text = {
    enabled = true,
  },
  action_kinds = { "quickfix", "refactor" },
  autocmd = { enabled = true },
  ignore = {
    actions_without_kind = true,
  },
})

require('actions-preview').setup {
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}
EOF

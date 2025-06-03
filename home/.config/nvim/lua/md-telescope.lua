vim.api.nvim_set_keymap('n', '<C-p>', 'HasGit() ? "<cmd>Telescope git_files<cr>" : "<cmd>Telescope find_files<cr>"', { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>lua require"telescope.builtin".find_files()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><C-p>', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>P', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>*', '<cmd>Telescope tags<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', '<cmd>Telescope search_history<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>:', '<cmd>Telescope command_history<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>:', '<cmd>Telescope commands<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>H', '<cmd>Telescope git_bcommits<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>"', '<cmd>Telescope registers<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>Telescope spell_suggest<cr>', { noremap = true, silent = true })

-- LSP
vim.api.nvim_set_keymap('n', '<leader>im', '<cmd>Telescope lsp_implementations<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>Telescope lsp_definitions<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sy', '<cmd>Telescope lsp_document_symbols<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rf', '<cmd>Telescope lsp_references<cr>', { noremap = true, silent = true })


local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
require('telescope').setup{
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
        height = 0.9,
        width = 0.8,
        preview_cutoff = 35,
        prompt_position = 'top',
    },
    results_title = false,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-s>"] = actions.file_split,
        ["<C-e>"] = action_layout.toggle_preview
      },
    },
    preview = {
        filesize_limit = 0.2, -- MB
    },
  },
  pickers = {
    lsp_definitions = {
    },
    lsp_document_symbols = {
    },
    lsp_implementations = {
    },
    lsp_references = {
    },
    registers = {
    },
    spell_suggest = {
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

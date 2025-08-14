local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local action_layout = require('telescope.actions.layout')

vim.keymap.set('n', '<C-p>', function()
  if vim.fn.HasGit() == 1 then
    builtin.git_files()
  else
    builtin.find_files()
  end
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', function() builtin.find_files() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader><C-p>', function() builtin.oldfiles() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>P', function() builtin.oldfiles() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>/', function() builtin.current_buffer_fuzzy_find() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>?', function() builtin.search_history() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>:', function() builtin.command_history() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader><leader>:', function() builtin.commands() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', function() builtin.help_tags() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>H', function() builtin.git_bcommits() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>"', function() builtin.registers() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>z', function() builtin.spell_suggest() end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-f>', function()
  builtin.live_grep({
    additional_args = function() return { "--hidden", "--glob=!**/.git/*" } end,
  })
end, { noremap = true, silent = true })
local function pick_dir_and_grep()
  builtin.find_files({
    layout_strategy = 'vertical',
    layout_config = {
        height = 0.7,
        width = 0.8,
        preview_height = 0.4,
        preview_cutoff = 15,
        prompt_position = 'top',
    },
    prompt_title = "Pick search directory",
    cwd = vim.fn.cwd(),
    find_command = { "fd", "--type", "d" },
    attach_mappings = function(prompt_bufnr, map)
      local function on_select()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry and entry[1] then
          builtin.live_grep({
            additional_args = function() return { "--hidden", "--glob=!**/.git/*" } end,
            search_dirs = { entry[1] },
          })
        end
      end
      map("i", "<CR>", on_select)
      map("n", "<CR>", on_select)
      return true
    end,
  })
end
vim.keymap.set('n', '<leader><C-f>', pick_dir_and_grep, { desc = "Live grep in chosen directory" })

-- LSP
vim.keymap.set('n', '<leader>im', function() builtin.lsp_implementations() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>df', function() builtin.lsp_definitions() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sy', function() builtin.lsp_document_symbols() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rf', function() builtin.lsp_references() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>*', function() builtin.lsp_workspace_symbols() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>qf', function() builtin.diagnostics() end, { noremap = true, silent = true })

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

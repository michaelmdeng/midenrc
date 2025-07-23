vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function nvimtree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.set("n", "s", api.node.open.horizontal, opts "Open: Horizontal Split")
  vim.keymap.set("n", "O", api.tree.expand_all, opts "Expand All")
  vim.keymap.set("n", "<C-r>", api.fs.rename, opts "Rename")
  vim.keymap.set("n", "r", api.tree.reload, opts "Refresh")
  vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
end

-- OR setup with some options
require("nvim-tree").setup({
  on_attach = nvimtree_on_attach,
  actions = {
    change_dir = {
      enable = false,
    },
  },
  update_focused_file = {
    enable = false,
    update_root = false,
  },
  respect_buf_cwd = false,
  sync_root_with_cwd = false,
  sort = {
    sorter = "name",
  },
  view = {
    width = 50,
    relativenumber = true,
  },
  filters = {
    custom = { "^.git$" },
  },
  log = {
    enable = true,
    truncate = true,
    types = {
      config = true,
      dev = true,
      diagnostics = true,
    },
  },
  renderer = {
    special_files = {},
    group_empty = true,
    symlink_destination = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
      padding = "",
      show = {
        file = false,
        folder_arrow = true,
        bookmarks = false,
      },
      glyphs = {
        folder = {
          arrow_open = "▷",
          arrow_closed = "▶",
          default = "/",
          open = "/",
          empty = "/",
          empty_open = "/",
          symlink = "/",
          symlink_open = "/",
        },
        git = {
          unstaged = "",
          staged = "⊕",
          unmerged = "",
          deleted = "✗",
        },
      },
    },
  },
})

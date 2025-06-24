require'nvim-treesitter.configs'.setup {
  ensure_installed={
    "bash",
    "comment",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitcommit",
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
    "jsonnet",
    "kotlin",
    "latex",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "requirements",
    "proto",
    "python",
    "regex",
    "ruby",
    "rust",
    "scala",
    "sql",
    "starlark",
    "toml",
    "tsv",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
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

require'treesitter-context'.setup{
  enable = true,
  max_lines = 4,
  min_window_height = 10,
  trim_scope = 'inner',
  separator = '-',
}

vim.keymap.set("n", "[x", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

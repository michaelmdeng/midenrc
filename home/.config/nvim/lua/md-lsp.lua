local api = vim.api

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  -- buffer
  buf_set_keymap('n', '<leader>a', '<cmd>lua require("actions-preview").code_actions()<CR>', opts)
  buf_set_keymap('n', '<leader>dc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>im', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<c-r>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>sg', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>Df', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- diagnostics
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

local nvim_lsp = require('lspconfig')

local function deep_merge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(t1[k]) == "table" then
      t1[k] = deep_merge(t1[k], v)
    else
      t1[k] = v
    end
  end
  return t1
end

local servers = {
  bashls = 'bash-language-server',
  cssls = 'css-languageserver',
  dockerls = 'docker-langserver',
  gopls = 'gopls',
  helm_ls = 'helm_ls',
  html = 'html-languageserver',
  lua_ls = 'lua-language-server',
  metals = 'metals',
  pylsp = 'pylsp',
  rust_analyzer = 'rust-analyzer',
  solargraph = 'solargraph',
  terraformls = 'terraform-ls',
  vimls = 'vim-language-server',
  yamlls = 'yamlls'
}

local custom_configs = {
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          autopep8 = { enabled = false },
          flake8 = { enabled = false },
          mccabe = { enabled = false },
          pydocstyle = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          rope_autoimport = { enabled = true },
          rope_completion = { enabled = true },
          ruff = { enabled = true },
          yapf = { enabled = false },
        }
      }
    }
  }
}

for lsp, exec in pairs(servers) do
  local cmd = string.format('executable(\'%s\')', exec)
  if (api.nvim_eval(cmd))
  then
    local lsp_opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }

    local custom_lsp_opts = custom_configs[lsp]
    if custom_lsp_opts then
      lsp_opts = deep_merge(lsp_opts, custom_lsp_opts)
    end

    nvim_lsp[lsp].setup(lsp_opts)
  end
end

api.nvim_create_user_command("LspCapabilities", function()
  local curBuf = api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients { bufnr = curBuf }

  local msg = "Press q or <Esc> to close this window.\n\n"
  for _, client in pairs(clients) do
    if client.name ~= "null-ls" then
      msg = msg .. "# " .. client.name .. "\n"
      local capAsList = {}
      for key, value in pairs(client.server_capabilities) do
        if value and key:find("Provider") then
          local capability = key:gsub("Provider$", "")
          table.insert(capAsList, "* " .. capability)
        end
      end
      table.sort(capAsList)
      msg = msg .. table.concat(capAsList, "\n") .. "\n"
    end
  end

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.7)
  local top = math.floor(((vim.o.lines - height) / 2))
  local left = math.floor((vim.o.columns - width) / 2)

  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(msg, "\n"))
  local opts = {
    style = 'minimal',
    relative = 'editor',
    row = top,
    col = left,
    width = width,
    height = height,
    focusable = true
  }

  local win_id = api.nvim_open_win(bufnr, true, opts)
  api.nvim_win_set_buf(win_id, bufnr)

  local function close()
    if api.nvim_win_is_valid(win_id) then
      api.nvim_win_close(win_id, true)
    end
  end
  vim.keymap.set('n', '<ESC>', close, { buffer = bufnr, nowait = true })
  vim.keymap.set('n', 'q', close, { buffer = bufnr, nowait = true })
end, {})

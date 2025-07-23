local dap = require("dap")

vim.fn.sign_define('DapBreakpoint', {text='⚈', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='⚈', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🡆', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='◌', texthl='', linehl='', numhl=''})

require('dap-python').setup()
require('dap-ruby').setup()

require('dap-go').setup {
  dap_configurations = {
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
      connect = {
        host = "127.0.0.1",
        port = "38697"
      }
    },
  },
  delve = {
    initialize_timeout_sec = 10,
    port = "38697",
  },
}

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

vim.keymap.set('n', '<F5>', '<cmd>lua require"dap".continue()<cr>', { silent = true })
vim.keymap.set('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<cr>', { silent = true })
vim.keymap.set('n', '<F10>', '<cmd>lua require"dap".step_over()<cr>', { silent = true })
vim.keymap.set('n', '<F11>', '<cmd>lua require"dap".step_into()<cr>', { silent = true })
vim.keymap.set('n', '<F12>', '<cmd>lua require"dap".step_out()<cr>', { silent = true })

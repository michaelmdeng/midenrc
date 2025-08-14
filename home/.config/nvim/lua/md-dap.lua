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

vim.keymap.set('n', '<F5>', function() dap.continue() end, { silent = true })
vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end, { silent = true })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { silent = true })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { silent = true })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { silent = true })

local M = {
  'mfussenegger/nvim-dap'
}

function M.init()
  local dap = require('dap')
  local wk = require('which-key')

  wk.register({
    d = {
      name = 'debug',
      b = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
      c = { dap.continue, 'Continue' },
      o = { dap.step_over, 'Step Over' },
      i = { dap.step_into, 'Step Into' },
      t = { dap.step_out, 'Step Out' },
    }
  }, { prefix = '<leader>' })
end

return M

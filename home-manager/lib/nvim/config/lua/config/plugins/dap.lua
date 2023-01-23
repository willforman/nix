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
      T = { dap.terminate, 'Terminate' },
      r = { dap.repl.toggle, 'Toggle repl' },
    }
  }, { prefix = '<leader>' })
end

function M.config()
  local dap = require('dap')

  dap.adapters.python = {
    type = 'executable',
    command = 'python3',
    args = { '-m', 'debugpy.adapter' },
  }

  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = 'launch file',
      program = '${file}',
    },
  }

end

return M

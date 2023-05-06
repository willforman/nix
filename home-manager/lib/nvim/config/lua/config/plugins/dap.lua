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

  dap.adapters = {
    python = {
      type = 'executable',
      command = 'python3',
      args = { '-m', 'debugpy.adapter' },
    },
    lldb = {
      type = 'executable',
      command = 'lldb-vscode',
      aname = 'lldb'
    }
  }

  dap.configurations = {
    python = {
      {
        type = 'python',
        request = 'launch',
        name = 'launch file',
        program = '${file}',
      },
    },
    rust = {
      {
        type = 'lldb',
        request = 'launch',
        name = 'launch file',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        initCommands = function()
          -- Find out where to look for the pretty printer Python module
          local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

          local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
          local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

          local commands = {}
          local file = io.open(commands_file, 'r')
          if file then
            for line in file:lines() do
              table.insert(commands, line)
            end
            file:close()
          end
          table.insert(commands, 1, script_import)

          return commands
        end,
      }
    }
  }

end

return M

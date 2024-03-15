local M = {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    "rcarriga/nvim-dap-ui"
  }
}

local string_utils = require('utils.string')
local table_utils = require('utils.table')

local Language = {
  RUST = 'rust',
  PYTHON = 'python',
}

DebuggerArgs = nil

local function get_current_language()
  local file_name = vim.api.nvim_buf_get_name(0)
  local parts = string_utils.split(file_name, '.')
  if table_utils.length(parts) ~= 2 then
    print("len want 2 got " .. vim.inspect(parts))
  end

  local file_ext = parts[2]
  if file_ext == "py" then
    return Language.PYTHON
  elseif file_ext == "rs" then
    return Language.RUST
  end

  return ""
end


local function get_node_text(ts_node_type_name)
  local ts = vim.treesitter
  local curr_node = ts.get_node()
  local bufnr = vim.api.nvim_get_current_buf()

  if type(bufnr) == "buffer" then
    print("exit: got buffer")
    return ""
  end

  if not curr_node then
    print("exit: no node before while")
    return ""
  end

  while curr_node do
    if curr_node:type() == ts_node_type_name then
      break
    end
    curr_node = curr_node:parent()
  end

  if not curr_node then
    print("exit: no node after while")
    return ""
  end

  local text = ts.get_node_text(curr_node, bufnr, nil)
  return text
end

local function get_project_name(project_path_str)
  return project_path_str:match("([^/]+)$")
end

local function compile_test(project_path_str, project_name)
  vim.fn.system("cd " .. project_path_str)
  local cargo_test_output = vim.fn.system("cargo test --no-run")
  return cargo_test_output:match("Executable%sunittests%s[%./%w]+%s%((target/debug/deps/" .. project_name .. "%-[%w]+)%)")
end

local function is_python_test()
  local project_utils = require('utils.project')
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_name = file_path:match("([^/]+)$")
  if not string_utils.starts_with(file_name, 'test_') then
    return false
  end

  local tests_path, _ = project_utils.get_project_path('tests')
  if not tests_path then
    return false
  end
  return true
end

local function get_python_args()
  if not is_python_test() then
    return nil
  end

  local file_path = vim.api.nvim_buf_get_name(0)

  local function_text = get_node_text("function_definition")
  local function_name = string.match(function_text, "def%s+([%w_]+)%(")

  local class_text = get_node_text("class_definition")
  local class_name = string.match(class_text, "class ([%w]+):")

  local test_path = ""
  if class_name then
    test_path = file_path .. '::' .. class_name .. '::' .. function_name
  else
    test_path = file_path .. '::' .. function_name
  end

  return { test_path }
end

local function get_rust_args()
  local function_text = get_node_text("function_item")
  local function_name = string.match(function_text, "fn%s+([%w_]+)%(")

  return { function_name }
end

local function set_current_args()
  local curr_lang = get_current_language()
  if curr_lang == Language.PYTHON then
    DebuggerArgs = get_python_args()
  elseif curr_lang == Language.RUST then
    DebuggerArgs = get_rust_args()
  end
  return ""
end

local function print_current_args()
  print(vim.inspect(DebuggerArgs))
end

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
      s = { set_current_args, 'Set current function to debug' },
      p = { print_current_args, 'Print current funciton to debug' },
    }
  }, { prefix = '<leader>' })
end

function M.config()
  local dap = require('dap')
  local project_utils = require('utils.project')

  dap.set_log_level('DEBUG')

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
        pythonPath = project_utils.get_python_path,
        program = function()
          if DebuggerArgs ~= nil then
            return nil
          end
          if is_python_test() then
            print("For debugging tests, use <leader>ds")
          end
          return '${file}'
        end,
        module = function()
          if DebuggerArgs ~= nil then
            return DebuggerArgs
          end
          return nil
        end
      },
    },
    rust = {
      {
        type = 'lldb',
        request = 'launch',
        name = 'launch file',
        program = function()
          local project_path_str, _ = project_utils.get_project_path("Cargo.toml")
          local project_name = get_project_name(project_path_str:absolute())
          local test_bin_path = compile_test(project_path_str:absolute(), project_name)
          return test_bin_path
        end,
        args = function()
          if DebuggerArgs ~= nil then
            print("Use <leader>dc to initially set args")
            return nil
          end
          return DebuggerArgs
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

  local dapui = require("dapui")
  dapui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

return M

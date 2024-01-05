local M = {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
}


local function get_current_function()
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
    if curr_node:type() == 'function_item' then
      break
    end
    curr_node = curr_node:parent()
  end

  if not curr_node then
    print("exit: no node after while")
    return ""
  end

  local text = ts.get_node_text(curr_node, bufnr, nil)

  local pattern = "fn%s+([%w_]+)%("
  local function_name = string.match(text, pattern)
  return function_name
end

local function get_cargo_project_path_str()
  local Path = require('plenary.path')
  local file_name = vim.api.nvim_buf_get_name(0)
  local curr_path = Path:new(file_name)

  while curr_path.filename do
    local cargo_toml_path = curr_path:joinpath('Cargo.toml')

    if cargo_toml_path:exists() then
      local maybe_workspace_path = curr_path:parent()

      local maybe_workspace_cargo_toml_path = maybe_workspace_path:joinpath('Cargo.toml')

      if maybe_workspace_cargo_toml_path:exists() then
        return curr_path:absolute(), maybe_workspace_path:absolute()
      else
        return curr_path:absolute(), nil
      end
    end
    curr_path = curr_path:parent()
  end

  return nil, nil
end

local function get_project_name(project_path_str)
  return project_path_str:match("([^/]+)$")
end

local function compile_test(project_path_str, project_name)
  vim.fn.system("cd " .. project_path_str)
  local cargo_test_output = vim.fn.system("cargo test --no-run")
  return cargo_test_output:match("Executable%sunittests%s[%./%w]+%s%((target/debug/deps/" .. project_name .. "%-[%w]+)%)")
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
    }
  }, { prefix = '<leader>' })
end

function M.config()
  local dap = require('dap')

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
        program = '${file}',
      },
    },
    rust = {
      {
        type = 'lldb',
        request = 'launch',
        name = 'launch file',
        program = function()
          local project_path_str, _ = get_cargo_project_path_str()
          local project_name = get_project_name(project_path_str)
          local test_bin_path = compile_test(project_path_str, project_name)
          return test_bin_path
        end,
        args = function()
          return {
            get_current_function()
          }
        end
        -- initCommands = function()
        --   -- Find out where to look for the pretty printer Python module
        --   local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
        --
        --   local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
        --   local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
        --
        --   local commands = {}
        --   local file = io.open(commands_file, 'r')
        --   if file then
        --     for line in file:lines() do
        --       table.insert(commands, line)
        --     end
        --     file:close()
        --   end
        --   table.insert(commands, 1, script_import)
        --
        --   return commands
        -- end,
      }
    }
  }
end

return M

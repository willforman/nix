local M = {}

function M.get_project_path(file_name_to_find)
  local Path = require('plenary.path')
  local file_name = vim.api.nvim_buf_get_name(0)
  local curr_path = Path:new(file_name)

  while curr_path.filename do
    local file_to_find = curr_path:joinpath(file_name_to_find)

    if file_to_find:exists() then
      local maybe_workspace_path = curr_path:parent()

      local maybe_workspace_path_to_find = maybe_workspace_path:joinpath(file_name_to_find)

      if maybe_workspace_path_to_find:exists() then
        return curr_path, maybe_workspace_path
      else
        return curr_path, nil
      end
    end
    curr_path = curr_path:parent()
  end

  return nil, nil
end

local function get_python_path_from_pyright_json(pyrightconfig_path)
  local file = io.open(pyrightconfig_path, "r")
  if not file then
    error("File not found: " .. pyrightconfig_path)
  end

  local content = file:read("*a")
  file:close()

  local venv_path = content:match('"venvPath"%s*:%s*"([^"]+)"')
  local venv = content:match('"venv"%s*:%s*"([^"]+)"')

  if venv_path and venv then
    return venv_path .. "/" .. venv .. "/bin/python"
  else
    error("Could not find venvPath and/or venv in the file.")
  end
end

function M.get_python_path()
  local file_name = "pyrightconfig.json"
  local project_path, _ = M.get_project_path(file_name)
  local pyproject_path = project_path:joinpath(file_name)
  local python_path = get_python_path_from_pyright_json(pyproject_path:absolute())
  return python_path
end

return M

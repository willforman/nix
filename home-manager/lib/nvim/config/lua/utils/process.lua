local M = {}

function M.subprocess_get_stdout(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  result:gsub('\n$', '')
  return result
end

return M

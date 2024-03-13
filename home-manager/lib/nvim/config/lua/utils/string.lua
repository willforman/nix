local M = {}

function M.starts_with(str, start)
  return str:sub(1, #start) == start
end

function M.split(str, sep)
  if sep == nil then sep = "%s" end

  local parts = {}
  for sub_str in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(parts, sub_str)
  end

  return parts
end

return M

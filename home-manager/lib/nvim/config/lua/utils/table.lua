local M = {}

function M.mergeTables(t1, t2)
  for i = 1, #t2 do
    table.insert(t1, t2[i])
  end
  return t1
end

function M.length(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

return M

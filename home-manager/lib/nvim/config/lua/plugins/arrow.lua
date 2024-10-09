local M = {
  'otavioschwanck/arrow.nvim',
}

function M.config()
  local arrow = require("arrow")
  arrow.setup({
    show_icons = true,
    leader_key = ';',
    buffer_leader_key = 'm',
  })
end

return M

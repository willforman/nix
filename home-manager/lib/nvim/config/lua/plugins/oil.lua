local M = {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  local oil = require("oil")
  oil.setup()
end

return M

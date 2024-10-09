local M = { 
  'echasnovski/mini.nvim',
  version = false 
}

function M.config()
  require('mini.surround').setup()
end

return M

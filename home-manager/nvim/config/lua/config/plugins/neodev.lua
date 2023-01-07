local M = {
  'folke/neodev.nvim',
  ft = { 'lua' }
}

function M.config()
  local neodev = require('neodev')
  neodev.setup({})
end

return M

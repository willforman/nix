local M = {
  'folke/trouble.nvim',
  cmd = { 'TroubleToggle', 'Trouble' }
}

function M.config()
  local trouble = require('trouble')
  trouble.setup({

  })
end

function M.init()
  vim.keymap.set('n', '<leader>oe', '<cmd>TroubleToggle<cr>', { desc = 'Open Trouble' })
end

return M

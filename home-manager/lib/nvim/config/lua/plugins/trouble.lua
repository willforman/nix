local M = {
  'folke/trouble.nvim',
  cmd = { 'Trouble' }
}

function M.config()
  local trouble = require('trouble')
  trouble.setup({})
end

function M.init()
  vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Open Trouble - all buffers' })
  vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Open Trouble - this buffer' })
end

return M

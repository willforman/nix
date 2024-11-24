local M = {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Open Trouble - all buffers' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Open Trouble - this buffer' },
  },
}

function M.config()
  local trouble = require('trouble')
  trouble.setup({})
end

return M

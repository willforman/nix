local M = {
  'folke/which-key.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
}

function M.config()
  local wk = require('which-key')
  wk.setup({})
end

return M

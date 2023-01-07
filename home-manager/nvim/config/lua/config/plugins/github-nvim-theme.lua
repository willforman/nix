local M = {
  'projekt0n/github-nvim-theme',
  lazy = false,
  dependencies = {
    'folke/trouble.nvim',
  },
}

function M.config()
  require('github-theme').setup({})
end

return M

local M = {
  'nvim-lualine/lualine.nvim',
}

function M.config()
  require('lualine').setup({
    options = {
      theme = 'auto'
    }
  })
end

return M

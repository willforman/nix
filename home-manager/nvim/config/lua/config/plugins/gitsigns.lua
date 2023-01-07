local M = {
  'lewis6991/gitsigns.nvim',
  tag = 'release',
  event = 'BufReadPre',
}

function M.config()
  require('gitsigns').setup({
    yadm = {
      enable = true
    }
  })
end

return M

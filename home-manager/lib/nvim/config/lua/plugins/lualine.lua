local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'otavioschwanck/arrow.nvim' },
}

function M.config()
  local arrow_statusline = require('arrow.statusline')

  require('lualine').setup({
    options = {
      theme = 'catppuccin'
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {
        {
          function ()
            return arrow_statusline.text_for_statusline_with_icons()
          end
        }
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  })
end

return M

return {
  'otavioschwanck/arrow.nvim',
  event = 'VeryLazy',
  config = function ()
    local arrow = require("arrow")
    arrow.setup({
      show_icons = true,
      leader_key = ';',
      buffer_leader_key = 'm',
    })
  end
}

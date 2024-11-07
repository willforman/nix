return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = 'VeryLazy',
  config = function ()
    local oil = require("oil")
    oil.setup()
  end
}

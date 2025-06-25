return {
  'echasnovski/mini.nvim',
  event = "VeryLazy",
  version = false,
  config = function ()
    local diff = require("mini.diff")
    diff.setup({
      source = diff.gen_source.none(),
    })

    require('mini.surround').setup()
  end
}

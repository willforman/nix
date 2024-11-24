return {
  'goolord/alpha-nvim',
  config = function ()
    local theme = require("alpha.themes.theta")
    theme.file_icons.provider = "devicons"

    require("alpha").setup(
      theme.config
    )
  end
}

local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font('JetBrains Mono')
config.font_size = 14.5

config.window_close_confirmation = 'NeverPrompt'

-- Fix text rendering as blocks: https://github.com/wez/wezterm/issues/5990
config.front_end = "WebGpu"

-- Key bindings
config.leader = { key = 'e', mods = 'CTRL', timeout_milliseconds = 1000 }

return config

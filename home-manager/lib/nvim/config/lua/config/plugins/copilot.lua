local M = {
  'folke/copilot.lua',
  cmd = "Copilot",
  event = "InsertEnter",
}

function M.config()
  local copilot = require('copilot')
  copilot.setup({
    suggestion = { enable = false },
    panel = { enable = false },
  })
end

return M

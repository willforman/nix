local M = {
  'windwp/nvim-autopairs',
  dependencies = {
    'windwp/nvim-ts-autotag'
  }
}

function M.config()
  require('nvim-autopairs').setup({})

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({
    map_char = { tex = ''}
  }))
end

return M

local M = {
  'L3MON4D3/LuaSnip',
  -- version = '<CurrentMajor>.*',
  -- build = 'make install_jsregexp',
}

function M.config()
  require('luasnip').setup({})
end

return M

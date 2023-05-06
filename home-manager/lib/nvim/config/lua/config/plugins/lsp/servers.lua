local M = {}

M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'},
        }
      }
    }
  },
  tsserver = {},
  eslint = {},
  pyright = {},
  gopls = {},
  rust_analyzer = {},
  svelte = {},
  html = {},
  cssls = {},
  elixirls = {
    cmd = { 'elixir-ls' },
  },
  nil_ls = {},
  bashls = {},
}

return M

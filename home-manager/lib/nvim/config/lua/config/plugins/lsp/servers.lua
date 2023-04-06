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
    cmd = {
      vim.fn.expand("~/.local/share/nvim/elixir-ls/language_server.sh")
    }
  },
  nil_ls = {},
  bashls = {},
}

return M

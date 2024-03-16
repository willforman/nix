local M = {}

M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
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
  ruff_lsp = {
    init_options = {
      settings = {
        args = { '--config', 'CONFIG_HERE' },
      }
    },
  },
  fennel_ls = {},
}

return M

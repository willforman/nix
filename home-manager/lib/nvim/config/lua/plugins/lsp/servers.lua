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
  ts_ls = {},
  eslint = {},
  pyright = {},
  gopls = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          allTargets = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
        }
      }
    }
  },
  svelte = {},
  html = {},
  cssls = {},
  elixirls = {
    cmd = { 'elixir-ls' },
  },
  nixd = {},
  bashls = {},
  ruff_lsp = {
    init_options = {
      settings = {
        args = { '--config', 'CONFIG_HERE' },
      }
    },
  },
  fennel_ls = {},
  roc_ls = {},
}

return M

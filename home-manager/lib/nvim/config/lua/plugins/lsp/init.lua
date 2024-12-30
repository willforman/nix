--@type lspconfig.options
local servers = {
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
        },
        diagnostics = false,
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
  ruff = {
    init_options = {
      settings = {
        args = { '--config', 'CONFIG_HERE' },
      }
    },
  },
  fennel_ls = {},
  roc_ls = {},
}

return {
  "neovim/nvim-lspconfig",
  event = "UIEnter",
  dependencies = {
   "hrsh7th/cmp-nvim-lsp",
  },
  opts = function ()
    ---@class PluginLspOpts
    local ret = {
      --@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
      },
      servers = servers,
    }

    return ret
  end,
  --param ops PluginLspOpts
  config = function (_, opts)
    local lspconfig = require("lspconfig")

    local function on_attach(client, bufnr)
      require('plugins.lsp.keys').init(client, bufnr)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local options = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    for server, server_opts in pairs(opts.servers) do
      server_opts = vim.tbl_deep_extend("force", {}, options, server_opts)
      lspconfig[server].setup(server_opts)
    end
  end
}

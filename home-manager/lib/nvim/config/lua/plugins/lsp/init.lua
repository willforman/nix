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
      --@type lspconfig.options
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              }
            }
          }
        },
      }
    }

    return ret
  end,
  --param ops PluginLspOpts
  config = function (_, opts)
    local lspconfig = require("lspconfig")
    for server, server_opts in pairs(opts.servers) do
      lspconfig[server].setup(server_opts)
    end
  end
}

-- local M = {
--   'neovim/nvim-lspconfig',
--   name = 'lsp',
--   event = 'UIEnter',
--   dependencies = {
--     'hrsh7th/cmp-nvim-lsp'
--   }
-- }
--
-- function M.config()
--   local function on_attach(client, bufnr)
--     require('plugins.lsp.keys').init(client, bufnr)
--   end
--
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
--   local options = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
--
--   local servers = require('plugins.lsp.servers').servers
--   for server, opts in pairs(servers) do
--     opts = vim.tbl_deep_extend("force", {}, options, opts)
--     require('lspconfig')[server].setup(opts)
--   end
-- end
--
-- return M

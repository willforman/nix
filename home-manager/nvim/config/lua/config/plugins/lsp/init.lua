local M = {
  'neovim/nvim-lspconfig',
  name = 'lsp',
  event = 'BufReadPre',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp'
  }
}

function M.config()
  local function on_attach(client, bufnr)
    require('config.plugins.lsp.keys').init(client, bufnr)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local servers = require('config.plugins.lsp.servers').servers
  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts)
    require('lspconfig')[server].setup(opts)
  end

  require('config.plugins.null-ls').setup(on_attach)
end

return M

local M = {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'folke/neodev.nvim',
    'zbirenbaum/copilot.lua',
    'zbirenbaum/copilot-cmp',
  }
}

function M.config()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'path'},
      { name = 'buffer'},
      { name = 'copilot' },
    }),
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort()
    }),
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  },
    {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      }
    })
  })


  local copilot = require('copilot')
  copilot.setup({
    suggestion = { enable = true },
    panel = { enable = false },
  })

  require("copilot_cmp").setup()
end

return M

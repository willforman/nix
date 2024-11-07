return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-file-browser.nvim',
    'danielfalk/smart-open.nvim',
    'kkharji/sqlite.lua', -- For smart-open
  },
  keys = {
    { '<leader><space>', function()
        require('telescope').extensions.smart_open.smart_open({
          cwd_only = true
        })
      end, desc = 'Find File', silent = true
    },
    {
      '<leader>/', function() require('telescope.builtin').live_grep() end, desc = 'Live Grep'
    },
    {
      '<leader>,', function() require('telescope.builtin').buffers() end, desc = 'See Buffers'
    },
    {
      '<leader>ht', function() require('telescope.builtin').help_tags() end, desc = 'Help Tags'
    },
    {
      '<leader>.', function()
        require('telescope').extensions.file_browser.file_browser({
          path = "%:p:h",
        })
      end, desc = 'File Browser'
    },
    {
      '<leader>s', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'Search LSP symbols'
    },
  },
  config = function ()
    local telescope = require('telescope')
    telescope.setup({})
    telescope.load_extension('file_browser')
    telescope.load_extension('smart_open')
  end,
}

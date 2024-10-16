local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-file-browser.nvim'
  },
}

function M.config()
  local telescope = require('telescope')

  telescope.setup({})

  telescope.load_extension('file_browser')
end

function M.init()
  vim.keymap.set('n', '<leader><space>', function()
    require('telescope').extensions.smart_open.smart_open({
      cwd = true
    })
  end, { desc = 'Find File' })

  vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').live_grep()
  end, { desc = 'Live Grep' })

  vim.keymap.set('n', '<leader>,', function()
    require('telescope.builtin').buffers()
  end, { desc = 'See Buffers' })

  vim.keymap.set('n', '<leader>ht', function()
    require('telescope.builtin').help_tags()
  end, { desc = 'Help Tags' })

  vim.keymap.set('n', '<leader>.', function()
    require('telescope').extensions.file_browser.file_browser({
      path = "%:p:h",
    })
  end, { desc = 'File Browser' })

  vim.keymap.set('n', '<leader>s', function()
    require('telescope.builtin').lsp_document_symbols()
  end, { desc = 'Search LSP symbols' })
end

return M

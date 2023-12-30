local M = {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
}

function M.config()
  local conform = require('conform')
  conform.setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { { 'prettierd', 'prettier' } },
      rust = { 'rustfmt' },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  })
end

function M.init()
  vim.keymap.set('n', '<leader>f', function ()
    require('conform').format({ async = true, lsp_fallback = true })
  end, { desc = 'Format' })
end

return M

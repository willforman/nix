local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
}

function M.config()
  require('catppuccin').setup({
    flavour = "mocha",
    integrations = {
      alpha = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      diffview = true,
      gitsigns = true,
      lsp_trouble = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
          ok = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
          ok = { 'underline' },
        },
        inlay_hints = {
          background = true,
        }
      },
      treesitter = true,
      telescope = { enabled = true },
      which_key = true,
    },
  })
  vim.cmd.colorscheme "catppuccin"
end

return M

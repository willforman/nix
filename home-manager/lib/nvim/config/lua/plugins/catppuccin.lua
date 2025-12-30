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
      blink_cmp = {
        style = 'bordered'
      },
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
      snacks = {
        enabled = true,
      },
      treesitter = true,
      which_key = true,
    },
    highlight_overrides = {
      mocha = function(mocha)
        return {
          LineNr = { fg = mocha.overlay1 },
        }
      end
    },
  })
  vim.cmd.colorscheme "catppuccin"
end

return M

local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
}

function M.config()
  require('catppuccin').setup({
    flavour = "mocha",
    integrations = {
      cmp = true,
      gitsigns = true,
      alpha = true,
      treesitter = true,
      telescope = { enabled = true },
      lsp_trouble = true,
      which_key = true,
    },
  })
  vim.cmd.colorscheme "catppuccin"
end

return M

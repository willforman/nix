local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
}

function M.config()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "lua", "rust", "elixir", "typescript", "go", "java", "python", "tsx" },
    sync_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    autotag = {
      enable = true,
    }
  })
end

return M

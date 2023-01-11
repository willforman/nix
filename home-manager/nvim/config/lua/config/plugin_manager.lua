require('lazy').setup('config.plugins', {
  performance = {
    -- so nvim can use treesitter installed through nix home manager
    reset_packpath = false,
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

vim.keymap.set('n', '<leader>ol', '<cmd>:Lazy<cr>', { desc = 'Open Lazy' })

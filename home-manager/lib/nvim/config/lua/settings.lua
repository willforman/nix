vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>cp', function()
  local rel_path = vim.fn.expand('%:p:.')
  vim.fn.setreg("+", rel_path)
end, { desc = 'Copy relative path to clipboard' })

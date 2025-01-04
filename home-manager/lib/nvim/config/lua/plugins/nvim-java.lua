return {
  'nvim-java/nvim-java',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function ()
    require('java').setup({
      jdk = {
        auto_install = false,
      }
    })
  end,
}

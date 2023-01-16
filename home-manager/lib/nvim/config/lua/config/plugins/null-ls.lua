local M = {
  'jose-elias-alvarez/null-ls.nvim',
}

function M.setup(old_on_attach)
  local function lsp_formatting(bufnr)
    vim.lsp.buf.format({
      filter = function (client)
        return client.name == 'null-ls'
      end,
      bufnr = bufnr,
    })
  end

  local function on_attach(client, bufnr)
    old_on_attach(client, bufnr)

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          lsp_formatting(bufnr)
        end
      })
    end
  end

  local nls = require('null-ls')
  nls.setup({
    sources = {
      nls.builtins.formatting.prettierd,
    },
    on_attach = on_attach,
  })
end

return M

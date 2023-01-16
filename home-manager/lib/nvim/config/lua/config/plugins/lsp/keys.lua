local M = { }

function M.init(_, bufnr)
  local wk = require('which-key')
  wk.register({
    buffer = bufnr,
    l = {
      name = 'lsp',
      d = { vim.lsp.buf.definition, 'Show Definition'},
      D = { vim.lsp.buf.declaration, 'Show Declaration'},
      h = { vim.lsp.buf.hover, 'Hover' },
      i = { vim.lsp.buf.implementation, 'Show Implementation' },
      s = { vim.lsp.buf.signature_help, 'Show Signature' },
      t = { vim.lsp.buf.type_definition, 'Show Type Definition' },
      r = { vim.lsp.buf.references, 'Show References' },
      w = {
        name = 'workspace',
        a = { vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder' },
        r = { vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder' },
        l = { print(vim.inspect(vim.lsp.buf.list_workspace_folders)), 'List Workspace Folders' },
      },
      a = {
        name = 'action',
        c = { vim.lsp.buf.code_action, 'Code Action' },
        r = { vim.lsp.buf.rename, 'Rename' },
      },
    },
    g = {
      name = 'diagnostics',
      f = { vim.diagnostic.open_float, 'Open Diagnostic Float' }
    },
  }, { prefix = '<leader>'})
end

return M

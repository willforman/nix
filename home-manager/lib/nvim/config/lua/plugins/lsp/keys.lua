local M = {}

function M.init(_, bufnr)
  local wk = require('which-key')

  wk.add({
    buffer = bufnr,
    { "<leader>g", group = "diagnostics" },
    { "<leader>gf", vim.diagnostic.open_float, desc = "Open Diagnostic Float" },

    { "<leader>l", group = "lsp" },
    { "<leader>lD", vim.lsp.buf.declaration, desc = "Show Declaration" },

    { "<leader>la", group = "action" },
    { "<leader>lac", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<leader>lar", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>ld", vim.lsp.buf.definition, desc = "Show Definition" },
    { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
    { "<leader>li", vim.lsp.buf.implementation, desc = "Show Implementation" },
    { "<leader>lr", vim.lsp.buf.references, desc = "Show References" },
    { "<leader>ls", vim.lsp.buf.signature_help, desc = "Show Signature" },
    { "<leader>lt", vim.lsp.buf.type_definition, desc = "Show Type Definition" },

    { "<leader>lw", group = "workspace" },
    { "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "Add Workspace Folder" },
    { "<leader>lwl", vim.lsp.buf.remove_workspace_folder, desc = "List Workspace Folders" },
    { "<leader>lwr", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "Remove Workspace Folder" },
  })
end

return M

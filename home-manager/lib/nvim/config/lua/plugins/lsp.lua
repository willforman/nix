--@type lspconfig.options
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        }
      }
    }
  },
  ts_ls = {},
  eslint = {},
  pyright = {},
  gopls = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          allTargets = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        diagnostics = false,
      }
    }
  },
  svelte = {},
  html = {},
  cssls = {},
  elixirls = {
    cmd = { 'elixir-ls' },
  },
  nixd = {},
  bashls = {},
  ruff = {
    init_options = {
      settings = {
        args = { '--config', 'CONFIG_HERE' },
      }
    },
  },
  fennel_ls = {},
  roc_ls = {},
  clangd = {},
  ty = {},
  jdtls = {},
}

local function on_attach(client, bufnr)
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

return {
  "neovim/nvim-lspconfig",
  event = "UIEnter",
  dependencies = {
   "hrsh7th/cmp-nvim-lsp",
  },
  opts = function ()
    ---@class PluginLspOpts
    local ret = {
      --@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
      },
      servers = servers,
      inlay_hints = {
        enabled = true,
        exclude = {},
      },
      codelens = {
        enabled = false,
      }
    }

    return ret
  end,
  --param ops PluginLspOpts
  config = function (_, opts)
    my_utils.lsp.setup()

    -- inlay hints
    if opts.inlay_hints.enabled then
      my_utils.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
        if
          vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end)
    end

    -- code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      my_utils.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local options = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    for server, server_opts in pairs(opts.servers) do
      server_opts = vim.tbl_deep_extend("force", {}, options, server_opts)
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end
  end
}

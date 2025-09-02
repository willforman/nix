return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {},
    picker = {
      sources = {
        explorer = {}
      }
    },
  },
  keys = {
    { "<leader><space>", function() Snacks.picker.smart({
      filter = { cwd = true },
      matcher = { frecency = true },
    }) end, desc = "Smart Find Files" },
    { "<leader>.", function() Snacks.picker.files({ cwd = "%:p:h" }) end, desc = "Smart Find Files In CWD" },
    -- { "<leader>.", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Find files in current directory" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Search Help Pages" },
    { "<leader>.", function() Snacks.explorer() end, desc = "Explore files" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  }
}

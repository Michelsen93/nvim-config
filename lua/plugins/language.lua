return {
  -- Helm templates
  {
    'towolf/vim-helm',
    ft = "helm",
  },
  -- Flutter/Dart
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      -- Note: on_attach is now handled globally via LspAttach autocmd
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      require("flutter-tools").setup({
        lsp = {
          capabilities = capabilities,
          settings = {
            dart = {
              analysisExcludedFolders = {
                vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
                vim.fn.expand("$HOME/.pub-cache"),
                vim.fn.expand("/opt/homebrew"),
                vim.fn.expand("$HOME/tools/flutter"),
              },
            },
          },
        },
      })
    end,
  },
}

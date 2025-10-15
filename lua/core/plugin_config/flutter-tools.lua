local on_attach = require("core.plugin_config.lsp_attach").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("flutter-tools").setup({
  lsp = {
    on_attach = on_attach,
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

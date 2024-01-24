require("mason").setup();
local lsp_config = require("lspconfig");
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "svelte", "gopls", "html", 'eslint', 'jsonls', 'cssls' },
  automatic_installation = true,
})

local on_attach = function(_,_)
  vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').biome.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}


require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp_config["gopls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lsp_config["dartls"].setup({
  on_attach = on_attach,
  settings = {
    dart = {
      analysisExlcudedFolders = {
        vim.fn.expand("HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("Home/.pub-cache"),
        vim.fn.expand("/opt/homebrew"),
        vim.fn.expand("$HOME/tools/flutter"),
      },
    }
  },
})

lsp_config['tsserver'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

require("fidget").setup({})

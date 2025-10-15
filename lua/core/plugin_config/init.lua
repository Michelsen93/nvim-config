require("core.plugin_config.lualine")
require("core.plugin_config.nvim-tree")
require("core.plugin_config.telescope")
require("core.plugin_config.treesitter")
require("core.plugin_config.lsp_config")
require("core.plugin_config.completions")
require("core.plugin_config.flutter-tools")
require("core.plugin_config.harpoon")
require("core.plugin_config.theme")
require("core.plugin_config.formatting")
require("core.plugin_config.git")

local universal_on_attach = require("core.plugin_config.lsp_attach").on_attach

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and bufnr then
      universal_on_attach(client, bufnr)
    end
  end,
})

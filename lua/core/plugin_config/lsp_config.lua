require("mason").setup()
local lsp_config = require("lspconfig")


local lsp_servers = {
    "lua_ls",
    "terraformls",
    "gopls",
    "jsonls",
    "cssls",
    "rust_analyzer",
    "zls",
    "ts_ls",
    "omnisharp",
    "templ",
    "dockerls",
    "html",
    "htmx",
    "bashls",
    "yamlls",
    "bicep",
}

require("mason-lspconfig").setup({
    ensure_installed = lsp_servers,
    automatic_installation = true,
})

vim.filetype.add({
    extension = {
        templ = "templ",
        tf = "terraform",
        tfvars = "terraform",
    }
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/templates/*.yaml", "*/templates/*.tpl" },
    callback = function()
        vim.bo.filetype = "helm"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    -- Normal mode mapping: <leader>ie
    vim.keymap.set("n", "<Space>ie", function()
      local line = "if err != nil {"
      local ret_line = "\treturn"
      local end_brace = "}"
      local row = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, row, row, false, { line, ret_line, end_brace })
    end, { buffer = true, desc = "Insert if err != nil { return }" })
  end,
})


local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp_server in ipairs(lsp_servers) do
    lsp_config[lsp_server].setup({
        capabilities = capabilities,
    })
end

lsp_config.yamlls.setup({
    capabilities = capabilities,
    filetypes = { "yaml", "helm" },
})

lsp_config.helm_ls.setup({
    filetypes = { "helm" },
    cmd = { "helm_ls", "serve" },
    settings = {
        ['helm-ls'] = {
            yamlls = { enabled = true }
        }
    },
    capabilities = capabilities,
})

require("fidget").setup({})

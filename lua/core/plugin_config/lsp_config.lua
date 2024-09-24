require("mason").setup()
local lsp_config = require("lspconfig")

local lsp_servers =  {
        "lua_ls",
        "terraformls",
        "svelte",
        "gopls",
        "html",
        "biome",
        "jsonls",
        "cssls",
        "rust_analyzer",
        "zls",
        "tsserver",
        "omnisharp",
        "templ",
        "dockerls",
        "html",
        "htmx",
        "bashls"
}

require("mason-lspconfig").setup({
    ensure_installed = lsp_servers,
    automatic_installation = true,
})

local on_attach = function(_, _)
    vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, {})
    vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set('n', '<Space>pr', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp_server in ipairs(lsp_servers) do
    lsp_config[lsp_server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

require("fidget").setup({})

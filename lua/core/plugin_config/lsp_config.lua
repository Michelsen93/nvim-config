require("mason").setup()
local lsp_config = require("lspconfig")
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
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
    },
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

lsp_config["templ"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.filetype.add({ extension = { templ = "templ" } })

lsp_config["biome"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["dockerls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["htmx"].setup({
    on_attach = on_attach,
    capabilities = capabilites,
})

lsp_config["html"].setup({
    on_attach = on_attach,
    capabilities = capabilites,
})

lsp_config["rust_analyzer"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["omnisharp"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["gopls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["zls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lsp_config["dartls"].setup({
	settings = {
		dart = {
			analysisExlcudedFolders = {
				vim.fn.expand("HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("Home/.pub-cache"),
				vim.fn.expand("/opt/homebrew"),
				vim.fn.expand("$HOME/tools/flutter"),
			},
		},
	},
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["tsserver"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_config["cssls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("fidget").setup({})

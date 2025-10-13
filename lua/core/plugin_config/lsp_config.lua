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


local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<Space>pr', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set("n", "<Space>de", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "<Space>dn", function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
    end, bufopts)
    vim.keymap.set("n", "<Space>dp", function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
    end, bufopts)

    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        vim.keymap.set("n", "<Space>da", telescope.diagnostics, bufopts)
    end

    vim.keymap.set("n", "<Space>dv", function()
        local current = vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = not current })
    end, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp_server in ipairs(lsp_servers) do
    lsp_config[lsp_server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

lsp_config.yamlls.setup({
    on_attach = on_attach,
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
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config["dartls"].setup({
    root_dir = require("lspconfig").util.root_pattern("pubspec.yaml"),
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
    on_attach = on_attach,
    capabilities = capabilities,

})

require("fidget").setup({})

-- lua/core/plugin_config/lsp_attach.lua

local M = {}

local diagnostics = require("core.plugin_config.diagnostics")
function M.on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    diagnostics.setup(bufopts)

    vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<Space>pr", function() vim.lsp.buf.format({ async = true }) end, bufopts)
    vim.keymap.set("n", "<Space>gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "<Space>gi", vim.lsp.buf.implementation,{})
    vim.keymap.set("n", "<Space>gr", require("telescope.builtin").lsp_references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<Space>gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
end

return M

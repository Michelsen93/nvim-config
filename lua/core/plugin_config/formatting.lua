require("conform").setup({
	event = { "BufReadPre", "BufNewFile" },
	formatters_by_ft = {
		typescript = { { "prettierd" } },
		typescriptreact = { { "prettierd" } },
		tsx = { { "prettierd" } },
		javascript = { { "prettierd" } },
		javascriptreact = { { "prettierd" } },
		json = { { "prettierd" } },
		html = { { "prettierd" } },
		css = { { "prettierd" } },
		lua = { "stylua" },
		["*"] = { { "prettierd" } },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	},
	notify_on_error = true,
})

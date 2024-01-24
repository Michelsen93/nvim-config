require("conform").setup({
	event = { "BufReadPre", "BufNewFile" },
	formatters_by_ft = {
		typescript = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		tsx = { { "prettierd", "prettier" } },
		javascript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		css = { { "prettierd", "prettier" } },
		lua = { "stylua" },
		["*"] = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	},
	notify_on_error = true,
})

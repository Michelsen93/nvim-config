require("conform").setup({
	event = { "BufReadPre", "BufNewFile" },
	formatters_by_ft = {
		typescript = { { "biome" } },
		typescriptreact = { { "biome" } },
		tsx = { { "biome" } },
		javascript = { { "biome" } },
		javascriptreact = { { "biome" } },
		json = { { "biome" } },
		html = { { "biome" } },
		css = { { "biome" } },
		lua = { "stylua" },
		["*"] = { { "biome" } },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	},
	notify_on_error = true,
})

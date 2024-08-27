return {
	"stevearc/conform.nvim",
	-- event = { "BufReadPre", "BufNewFile" }, -- for format on save
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "42norm_format" },
			-- css = { "prettier" },
			-- html = { "prettier" },
		},
		formatters = {
			["42norm_format"] = {
				inherit = false,
				command = "42norm_format",
				args = { vim.fn.expand("%:p") },
				stdin = false,
			},
		},
		-- format_on_save = {
		--   -- These options will be passed to conform.format()
		--   timeout_ms = 500,
		--   lsp_fallback = true,
		-- },
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}

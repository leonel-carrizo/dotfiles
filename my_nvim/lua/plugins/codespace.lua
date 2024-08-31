return {
	{
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
					args = { vim.fn.expand "%:p" },
					stdin = false,
				},
			},
			-- format_on_save = {
			--   -- These options will be passed to conform.format()
			--   timeout_ms = 500,
			--   lsp_fallback = true,
			-- },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "InsertEnter",
		opts = function()
			return {
				indent = { char = "│", tab_char = "│" },
				scope = { show_start = false, show_end = false, char = "│" },
				exclude = {
					filetypes = {
						"help",
						"alpha",
						"dashboard",
						"neo-tree",
						"Trouble",
						"trouble",
						"lazy",
						"mason",
						"notify",
						"toggleterm",
						"lazyterm",
					},
				},
			}
		end,
		main = "ibl",
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdateSync" },
		build = ":TSUpdate",
		event = { "VeryLazy", "BufReadPost", "BufNewFile" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require "nvim-treesitter.query_predicates"
		end,
		opts = {
			highlight = { enable = true, use_languagetree = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

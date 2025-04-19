local home_path = os.getenv "HOME" .. "/"

return {
	-- for formatting files
	{
		"stevearc/conform.nvim",
		-- event = { "BufReadPre", "BufNewFile" }, -- for format on save
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- c = { "42norm_format" },
				css = { "prettier" },
				html = { "prettier" },
				-- javascript = { "prettier", "standardjs" },
				markdown = { "markdownlint" },
			},
			-- customize a formatter
			-- formatters = {
			-- 	["markdownlint"] = {
			-- 		args = function()
			-- 			local styles_path = conf_path .. "/markdownlint/.markdownlint.jsonc"
			-- 			return { "--fix", "--config", styles_path, "$FILENAME" }
			-- 		end,
			-- 		stdin = false,
			-- 	},
			-- },
			-- format_on_save = {
			-- 	-- These options will be passed to conform.format()
			-- 	timeout_ms = 500,
			-- 	lsp_fallback = true,
			-- },
		},
	},
	-- manage linter for languages
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require "lint"

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "standardjs" },
				javascriptreact = { "standardjs" },
				typescriptreact = { "standardjs" },
				markdown = { "markdownlint" },
				c = { "norminette" },
				h = { "norminette" },
				cpp = { "norminette" },
			}

			-- modify markdown rules
			local styles_path = home_path .. ".config/markdownlint/.markdownlint.jsonc"
			lint.linters["markdownlint"].args = { "--stdin", "-c", styles_path, "-" }

			lint.linters.norminette = {
				cmd = "norminette",
				stdin = false,
				append_fname = true,
				args = {},
				ignore_exitcode = true,
				stream = "stdout",
				parser = function(output, bufnr)
					local diagnostics = {}
					for line in vim.gsplit(output, "\n") do
						-- formato: file: Error: DESCRIPTION (line: xx, col xx): message
						-- [[Error:%s+(%S+)%s+%(%s*line:%s*(%d+),%s*col:%s*(%d+)%):%s+(.+)]]
						local code, lnum, col, msg =
							line:match [[Error:%s+([%a+_?]+)%s+%(line:%s+(%d+),%s+col:%s+(%d+)%):%s+(.*)$]]
						if code and lnum and col and msg then
							table.insert(diagnostics, {
								bufnr = bufnr,
								lnum = tonumber(lnum) - 1,
								col = tonumber(col) - 1,
								message = "Norm_Err: " .. msg,
								severity = vim.diagnostic.severity.ERROR,
								source = "norminette",
							})
						end
					end
					return diagnostics
				end,
			}

			-- tigger the linters whit autocommand
			local lint_enabled = true -- Inicialmente, el linter está activado
			local lint_augorup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd(
				{ "BufEnter", "BufWritePost", "InsertLeave", "InsertEnter", "TextChanged", "TextChangedI" },
				{
					group = lint_augorup,
					callback = function()
						if lint_enabled then
							lint.try_lint()
						end
					end,
				}
			)

			-- autocommand for markdown Syntax_aware
			local lint_syntax = false
			local lint_syntax_group = vim.api.nvim_create_augroup("lint_syntax", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_syntax_group,
				callback = function()
					if lint_syntax then
						lint.try_lint "vale"
					end
				end,
			})

			-- keymaps
			vim.keymap.set("n", "<leader>ll", function()
				lint_enabled = not lint_enabled
				if lint_enabled then
					vim.notify("Linter activated", vim.log.levels.INFO)
				else
					vim.diagnostic.reset()
					vim.notify("Linter deactivated", vim.log.levels.INFO)
				end
			end, { desc = "Toggle linting for current file" })

			vim.keymap.set("n", "<leader>lm", function()
				lint_syntax = not lint_syntax
				if lint_syntax then
					vim.notify("Syntax-aware enabled", vim.log.levels.INFO)
				else
					vim.diagnostic.reset()
					vim.notify("Syntan-aware disabled", vim.log.levels.INFO)
				end
			end, { desc = "Tigger Syntax-aware linter" })
		end,
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
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- set to `false` to disable one of the mappings
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

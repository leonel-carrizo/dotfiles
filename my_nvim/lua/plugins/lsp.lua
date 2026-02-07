return {
	{
		"neovim/nvim-lspconfig",
		envent = "VeryLazy",
		-- See: http://www.lazyvim.org/plugins/lsp#nvim-lspconfig
		config = function()
			local lspopts = require "config.lsp-config"
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- load defaults for lua
			lspopts.defaults()

			local servers = {
				"eslint",
				"ts_ls",
				"rust_analyzer",
				"html",
				"cssls",
				"pyright",
				"jsonls",
				"bashls",
				"marksman",
				"somesass_ls",
			}

			vim.lsp.enable(servers)

			vim.lsp.config (
				"clangd", {
					capabilities = lsp_capabilities,
					cmd = { "clangd", "--clang-tidy" },
					init_options = {
						fallbackFlags = {}, -- empty so you must create a compile_commands.json
					},
				},
				"eslint", {
					on_attach = function(_, bufnr)
						lspopts.on_attach(_, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
					capabilities = lsp_capabilities,
				}
				)
		end,
		dependencies = { "williamboman/mason.nvim" },
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			envent = "VeryLazy",
		},
		opts = {
			-- PATH = "skip",
			ui = {
				border = "none",
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ",
				},
			},
			max_concurrent_installers = 5,
			ensure_installed = { -- Instal any client from Mason repo
				"markdownlint",
				"markdown-toc",
				"prettier",
				"bashls",
				"html-lsp",
				"some-sass-language-server",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			require("mason-lspconfig").setup {
				-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
				ensure_installed = { -- install ONLY LSP SERVERS
					"eslint",
					"rust_analyzer",
					"html",
					"ts_ls",
					"pyright",
					"jsonls",
					"cssls",
					"pyright",
					"marksman",
					-- "asm_lsp",
					"bashls",
				},
				automatic_installation = true,
			}
		end,
	},
}

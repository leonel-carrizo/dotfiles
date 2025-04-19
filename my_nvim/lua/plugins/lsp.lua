return {
	{
		"neovim/nvim-lspconfig",
		-- this fucntion must returns a table, this will applay for all servers
		-- if this is set, you must change the `config` approach. `config` override this.
		-- See: http://www.lazyvim.org/plugins/lsp#nvim-lspconfig
		opts = function()
			return {}
		end,
		config = function()
			local lspconfig = require "lspconfig"
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- load defaults for lua
			require("config.lsp-config").defaults()

			local lspopts = require "config.lsp-config"

			local servers = {
				-- "lua_ls",
				"clangd",
				-- "eslint",
				"ts_ls",
				"rust_analyzer",
				"html",
				"cssls",
				"pyright",
				"emmet_ls",
				"jsonls",
				"bashls",
				"marksman",
			}

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					on_attach = lspopts.on_attach,
					on_init = lspopts.on_init,
					-- capabilities = lspopts.capabilities,
					capabilities = lsp_capabilities,
				}
			end
			-- lsp individual for javascript
			lspconfig.eslint.setup {
				on_attach = function(_, bufnr)
					lspopts.on_attach(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				-- on_init = lspopts.on_init,
				capabilities = lspopts.capabilities,
			}
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
			ensure_installed = {
				"markdownlint",
				"clangd",
				"markdown-toc",
				"prettier",
				"stylua",
				"bashls",

			}
		},
		config = function(_, opts)
			require("mason").setup(opts)
			require("mason-lspconfig").setup {
				-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
				ensure_installed = {
					"lua_ls",
					"clangd",
					"eslint",
					"rust_analyzer",
					"html",
					"ts_ls",
					"pyright",
					"jsonls",
					"cssls",
					"pyright",
					"emmet_ls",
					"marksman",
					"asm_lsp",
					"bashls",
				},
				automatic_installation = true,
			}
		end,
	},
}

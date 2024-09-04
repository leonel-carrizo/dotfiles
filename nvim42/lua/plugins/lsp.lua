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

			-- load defaults
			require("config.lsp-config").defaults()

			local lspopts = require "config.lsp-config"

			local servers = { "clangd" }

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					on_attach = lspopts.on_attach,
					on_init = lspopts.on_init,
					capabilities = lspopts.capabilities,
				}
			end
			-- -- lsp whit individual settings
			-- typescript
			-- lspconfig.tsserver.setup {
			--   on_attach = on_attach,
			--   on_init = on_init,
			--   capabilities = capabilities,
			-- }
		end,
		dependencies = { "williamboman/mason.nvim" },
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			envent = "VeryLazy",
			config = function()
				require("mason-lspconfig").setup {
					ensure_installed = {
						"lua_ls",
						"clangd",
					},
					automatic_installation = true,
				}
			end,
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
			max_concurrent_installers = 10,
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
}

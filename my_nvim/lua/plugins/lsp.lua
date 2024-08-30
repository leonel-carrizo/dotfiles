local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
	map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
	map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts "List workspace folders")

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

	map("n", "<leader>ra", function()
		require("utils.lsprenamer").rename()
	end, opts "NvRenamer")

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
	map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method "textDocument/semanticTokens" then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local diagnostic_config = function ()
	local x = vim.diagnostic.severity
	vim.diagnostic.config {
		virtual_text = { prefix = "" },
		signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
		underline = true,
		float = { border = "single" },
	}
end

M.defaults = function()
	diagnostic_config()

	require("lspconfig").lua_ls.setup {
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand "$VIMRUNTIME/lua",
						vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
						vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
						vim.fn.stdpath "data" .. "mason/bin",
						"${3rd}/luv/library",
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	}
end

return {
	{
		"neovim/nvim-lspconfig",
		-- this fucntion must returns a table, this will applay for all servers
		-- if this is set, you must change the `config` approach. `config` override this.
		-- See: http://www.lazyvim.org/plugins/lsp#nvim-lspconfig
		opts = function ()
			return {}
		end,
		config = function()
			M.defaults()
			local lspconfig = require "lspconfig"
			local servers = {
				"clangd",
			}
			-- lsps with default config
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					on_attach = M.on_attach,
					on_init = M.on_init,
					capabilities = M.capabilities,
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
		dependencies = { "williamboman/mason.nvim", },
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			envent = "VeryLazy",
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = {
						"lua_ls",
						"clangd",
					},
					automatic_installation = true,
				})
			end
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
		config = function (_, opts)
			require("mason").setup(opts)
		end
	}
}

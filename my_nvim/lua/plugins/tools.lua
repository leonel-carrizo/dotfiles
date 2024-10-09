return {

	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		dir = "~/.config/nvim/lua/local/term",
		lazy = true,
		keys = {
			{ "<C-x>", "<C-\\><C-N>", mode = "t", desc = "Terminal scape to normal mode" },
			{
				"<leader>x",
				function(bufnr)
					bufnr = bufnr or vim.api.nvim_get_current_buf()
					vim.cmd "close"
					vim.api.nvim_buf_delete(bufnr, { force = true })
				end,
				mode = { "t" },
				desc = "Close Terminal",
			},
			{
				"<leader>h",
				function()
					require("local.term").new { pos = "sp" }
				end,
				desc = "New horizontal terminal",
			},
			{
				"<leader>v",
				function()
					require("local.term").new { pos = "vsp" }
				end,
				desc = "New vertical terminal",
			},
			{
				"<A-g>",
				function()
					require("local.term").toggle {
						pos = "float",
						float_opts = {
							style = "minimal",
						},
						cmd = "lazygit",
						id = "floatLazyGit",
						external = true,
						clear_cmd = true,
					}
				end,
				mode = { "t", "n" },
				desc = "Terminal Open Lazygit on toggle float mode",
			},
			{
				"<A-v>",
				function()
					require("local.term").toggle {
						pos = "vsp",
						id = "vtoggleTerm",
					}
				end,
				mode = { "t", "n" },
				desc = "Terminal toggleable vertical",
			},
			{
				"<A-t>",
				function()
					require("local.term").toggle {
						pos = "sp",
						id = "htoggleTerm",
					}
				end,
				mode = { "t", "n" },
				desc = "Terminal toggleable horizontal",
			},
			{
				"<A-i>",
				function()
					require("local.term").toggle {
						pos = "float",
						id = "floatTerm",
					}
				end,
				mode = { "t", "n" },
				desc = "Terminal float toggleable",
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		cmd = "WhichKey",
		opts_extend = { "spec" },
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show { global = false }
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<c-w><space>",
				function()
					require("which-key").show { keys = "<c-w>", loop = true }
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
		opts = {
			defaults = {},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>t", group = "Theme", icon = "" },
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>c", group = "code" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					-- better descriptions
					{ "gx", desc = "Open with system app" },
				},
			},
		},
		config = function(_, opts)
			local wk = require "which-key"
			wk.setup(opts)
			if not vim.tbl_isempty(opts.defaults) then
				vim.notify("which-key: opts.defaults is deprecated. Please use opts.spec instead.", vim.log.levels.WARN)
				wk.register(opts.defaults)
			end
		end,
	},
	-- Session management. This saves your session in the background,
	-- keeping track of open buffers, window arrangement, and more.
	-- You can restore sessions when returning through the dashboard.
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		-- stylua: ignore
		keys = {
			{ "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
			{ "<leader>qS", function() require("persistence").select() end,              desc = "Select a session to restore" },
			{ "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
		},
	},
}

return {
	-- file managing , picker etc
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = {
			filters = { dotfiles = false },
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = false,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			view = {
				width = 30,
				preserve_window_proportions = true,
			},
			renderer = {
				group_empty = true,
				root_folder_label = false,
				highlight_git = true,
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						default = "󰈚",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
						},
						git = { unmerged = "" },
					},
				},
			},
		},
		-- config = function (_, opts)
		-- on_atach = function()
		-- somethin
		--end
	},
	{
		{
			"nvim-neo-tree/neo-tree.nvim",
			cmd = "Neotree",
			keys = {
				{
					"<leader>fe",
					function()
						require("neo-tree.command").execute {
							toggle = true,
							dir = require("utils.paths_utils").root_dir(),
						}
					end,
					desc = "Explorer NeoTree (Root Dir)",
				},
				{
					"<leader>fE",
					function()
						require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
					end,
					desc = "Explorer NeoTree (cwd)",
				},
				{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
				{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
				{
					"<leader>ge",
					function()
						require("neo-tree.command").execute { source = "git_status", toggle = true }
					end,
					desc = "Git Explorer",
				},
				{
					"<leader>be",
					function()
						require("neo-tree.command").execute { source = "buffers", toggle = true }
					end,
					desc = "Buffer Explorer",
				},
				{ "<leader>e", function ()
					require("neo-tree.command").execute({ action = "focus" })
				end, desc = "Explorer NeoTree focus",
				},
				{
					"<leader>fc", function ()
						vim.cmd("tabnew")
						require("neo-tree.command").execute({ action = "focus", dir =  vim.fn.stdpath('config')})
					end, desc = "Open NeoVim settings files on new tab"
				}
			},
			deactivate = function()
				vim.cmd [[Neotree close]]
			end,
			init = function()
				-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
				-- because `cwd` is not set up properly.
				vim.api.nvim_create_autocmd("BufEnter", {
					group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
					desc = "Start Neo-tree with directory",
					once = true,
					callback = function()
						if package.loaded["neo-tree"] then
							return
						else
							local stats = vim.uv.fs_stat(vim.fn.argv(0))
							if stats and stats.type == "directory" then
								require "neo-tree"
							end
						end
					end,
				})
			end,
			opts = function()
				return require "config.neo-tree-config"
			end,
			config = function(_, opts)
				-- update sources after rename.
				local function on_move(data)
					local conf = require "utils.lsprenamer"
					conf.on_rename(data.source, data.destination)
				end
				local events = require "neo-tree.events"
				opts.event_handlers = opts.event_handlers or {}
				vim.list_extend(opts.event_handlers, {
					{ event = events.FILE_MOVED, handler = on_move },
					{ event = events.FILE_RENAMED, handler = on_move },
				})
				-- set settings
				require("neo-tree").setup(opts)
				vim.api.nvim_create_autocmd("TermClose", {
					pattern = "*lazygit",
					callback = function()
						if package.loaded["neo-tree.sources.git_status"] then
							require("neo-tree.sources.git_status").refresh()
						end
					end,
				})
			end,
		},
	},
	-- tabs management
	{
		-- basic buffer manager taken form Nvchad
		dir = "~/.config/nvim/lua/local/tabufline",
		-- enabled = false,
		event = "BufReadPre",
		config = function()
			require "local.tabufline.lazyload"
		end,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slope",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			-- require("my_nvim.lua.plugins.statusline").setup(opts)
			require("lua.plugins.statusline").setup(opts)
		end,
	},
}

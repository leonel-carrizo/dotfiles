-- local pre_settings = function(color)
-- color = color or {}
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

return {
	{ "echasnovski/mini.icons" },
	{ "MunifTanjim/nui.nvim",  lazy = true },
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return { override = require("utils.devicons") }
		end,
	},
	-- basic buffer manager taken form Nvchad
	{
		dir = "~/.config/nvim/lua/local/tabufline",
		-- enabled = false,
		config = function()
			require("local.tabufline.lazyload")
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set header
			dashboard.section.header.val = {

				"                                                                       ",
				"                                                                       ",
				"                                                                       ",
				"  ██████   █████                   █████   █████  ███                  ",
				" ░░██████ ░░███                   ░░███   ░░███  ░░░                   ",
				"  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ",
				"  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ",
				"  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ",
				"  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ",
				"  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ",
				" ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ",
				"                                                                       ",
				"                                                                       ",
				"                                                                       ",

			}
			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("n", "  New File", "<cmd>ene<CR>"),
				dashboard.button("e", "󰙅  Toggle file explorer", "<cmd>Neotree<CR>"),
				dashboard.button("f", "󰱼  Find File CWD", "<cmd>Telescope find_files<CR>"),
				dashboard.button("h", "󱂶  Find in Home Directory",
					"<cmd>lua require('telescope.builtin').find_files({hidden=true, cwd=require('utils.paths_utils').root_dir({home = true})})<CR>"),
				dashboard.button("o", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("k", "󰌓  Find a Keymap", "<cmd>Telescope keymaps<CR>"),
				dashboard.button("r", "󰁯  Restore Session For Current Directory",
					"<cmd>lua require('persistence').load()<CR>"),
				dashboard.button("s", "  Select a session to restore", "<cmd>lua require('persistence').select()<CR>"),
				dashboard.button("l", "󰒲  Open Lazy pluging manager", "<cmd>Lazy<CR>"),
				dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
			}
			-- Send config to alpha
			alpha.setup(dashboard.opts)

			-- Disable folding on alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		-- enabled = false,
		lazy = false,
		priority = 1000,
		-- configs at https://github.com/folke/tokyonight.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
		opts = {
			-- style = "storm",
			transparent = false,
			terminal_colors = false,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
		},
		config = function(_, opts)
			local tokyo = require("tokyonight")
			tokyo.setup(opts)
			tokyo.load()
			-- pre_settings()
		end,
	},
	{
		"sainnhe/sonokai",
		-- enabled = false,
		lazy = false,
		priority = 1001,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.sonokai_enable_italic = true
			--vim.cmd.colorscheme('sonokai')
		end
	},
	{
		"catppuccin/nvim",
		-- enabled = false,
		name = "catppuccin",
		priority = 1002,
		lazy = false,
		opts = {
			transparent_background = false,
			flavour = "mocha",
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		cmd = { "ShowColor" },
		keys = { { "<leader>cs", "<cmd>ColorizerToggle<cr>", desc = "Toggle highlight colors in file" } },
		opts = {
			user_default_options = { names = false },
			filetypes = {
				"*",
				"!lazy",
			},
		},
		config = function(_, opts)
			require("colorizer").setup(opts)

			-- execute colorizer as soon as possible
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
}

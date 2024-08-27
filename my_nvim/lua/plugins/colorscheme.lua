-- local pre_settings = function(color)
-- 	color = color or {}
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

return {
	{
		"folke/tokyonight.nvim",
		-- enabled = false,
		lazy = false,
		priority = 1000,
		--  configs at https://github.com/folke/tokyonight.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
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
	keys = { {"<leader>cs", "<cmd>ColorizerToggle<cr>", desc = "Toggle highlight colors in file" } },
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

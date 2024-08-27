return {
	"echasnovski/mini.icons",
	{"nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "utils.devicons" }
    end,
	},
	-- basic buffer manager taken form Nvchad
	{ dir = "~/.config/nvim/lua/local/term",	lazy = true },
	{
		dir = "~/.config/nvim/lua/local/tabufline",
		-- enabled = false,
		config = function ()
				require("local.tabufline.lazyload")
			end
	},
}

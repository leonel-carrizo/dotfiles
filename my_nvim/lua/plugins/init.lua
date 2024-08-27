return {
	"echasnovski/mini.icons",
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return { override = require("utils.devicons") }
		end,
	},
	-- basic buffer manager taken form Nvchad
	{ dir = "~/.config/nvim/lua/local/term", lazy = true },
	{
		dir = "~/.config/nvim/lua/local/tabufline",
		-- enabled = false,
		config = function()
			require("local.tabufline.lazyload")
		end,
	},
	-- header 42London
	{
		dir = "$HOME/.vim/plugin/stdheader.vim",
		lazy = true,
		cmd = "Stdheader",
		keys =
			{"<F1>", "<cdm>Stdheader<CR>", mode = 'n', remap = true, silent = true, desc = "42 Header for C Files."},
		ft = {"c", "Makefile"},
		config = function ()
			vim.cmd("source $HOME/.vim/plugin/stdheader.vim")
		end
	},
}

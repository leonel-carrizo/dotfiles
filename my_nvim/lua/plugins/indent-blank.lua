return {
	"lukas-reineke/indent-blankline.nvim",
	event = "InsertEnter",
	opts = function()
		return {
			indent = { char = "│", tab_char = "│"	},
			scope = { show_start = false, show_end = false , char = "│" },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		}
	end,
	main = "ibl",
	config = function(_, opts)
		require("ibl").setup(opts)
	end
}

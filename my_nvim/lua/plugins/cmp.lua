return {
	"hrsh7th/nvim-cmp",
	-- commit = "b356f2c80cb6c5bae2a65d7f9c82dd5c3fdd6038", -- https://github.com/hrsh7th/nvim-cmp/issues/1877
	-- pin = true,
	lazy = true,
	event = "InsertEnter",
	dependencies = {
		{
			-- snippet plugin
			"L3MON4D3/LuaSnip",
			dependencies = "rafamadriz/friendly-snippets",
			opts = { history = true, updateevents = "TextChanged,TextChangedI" },
			config = function(_, opts)
				require("luasnip").config.set_config(opts)
				require "utils.luasniprc"
			end,
		},

		-- autopairing of (){}[] etc
		{
			"windwp/nvim-autopairs",
			opts = {},
			config = function(_, opts)
				require("nvim-autopairs").setup {
					disable_filetype = { "TelescopePrompt", "vim" },
					fast_wrap = {
						map = "<D-i>",
						chars = { "{", "[", "(", '"', "'", "<" },
						pattern = [=[[%'%"%>%]%)%}%,]]=],
						end_key = "$",
						before_key = "h",
						after_key = "l",
						cursor_pos_before = true,
						keys = "qwertyuiopzxcvbnmasdfghjkl",
						manual_position = true,
						highlight = "Search",
						highlight_grey = "Comment",
					},
				}

				-- setup cmp for autopairs
				local cmp_autopairs = require "nvim-autopairs.completion.cmp"
				require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
		},
		{
			-- cmp sources plugins
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "hrsh7th/cmp-cmdline",
			-- "rafamadriz/friendly-snippets",
			-- "saadparwaiz1/cmp_luasnip",
		},
	},
	opts = function()
		return require "config.cmp-config"
	end,
}

return {
	-- load luasnips + cmp related in insert mode only
	"hrsh7th/nvim-cmp",
	lazy = true,
	-- event = "InsertEnter",
	dependencies = {
		{
			-- cmp sources plugins
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
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
						chars = { "{", "[", "(", '"', "'" },
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
	},
	opts = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		return require "config.cmp-config"
	end,
}

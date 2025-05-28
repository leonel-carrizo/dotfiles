return {
	{
		-- https://github.com/MeanderingProgrammer/render-markdown.nvim
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		opts = {
			sign = { enabled = false },
			heading = {
				icons = { "󱗼 " },
			},
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			render_modes = { "n", "c", "t", "v", "i" },
			preset = "obsidian",
			dash = {
				width = 80,
			},
			indent = {
				enabled = true,
				skip_heading = true,
			},
			checkbox = {
				unchecked = {
					icon = "󰄱",
				},
				checked = {
					icon = "",
				}
			}
		},
		config = function(_, opts)
			require("obsidian").get_client().opts.ui.enable = false
			-- vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()["ObsidianUI"], 0, -1)
			require("render-markdown").setup(opts)
		end,
	},
	{
		"3rd/image.nvim",
		event = "VeryLazy",
		-- https://github.com/3rd/image.nvim?tab=readme-ov-file#default-configuration
		opts = {
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = true,
					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					--- TODO: Fix how the images are searched look at -> https://github.com/3rd/image.nvim/issues/190#issuecomment-2378156235
					-- resolve_image_path = function(document_path, image_path, fallback)
					-- document_path is the path to the file that contains the image
					-- image_path is the potentially relative path to the image. for
					-- markdown it's `![](this text)`

					-- you can call the fallback function to get the default behavior
					-- return fallback(document_path, image_path)
					-- end,
				},
				neorg = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "norg" },
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = 50,
			kitty_method = "normal",
		},
	},
}

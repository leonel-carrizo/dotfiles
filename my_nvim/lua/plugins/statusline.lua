return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			local utils = require "utils.paths_utils"
			local icons = require "utils.icons"
			local lualine_require = require "lualine_require"
			lualine_require.require = require

			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = "auto",
					disabled_filetypes = {
						statusline = { { "dashboard", "alpha" } },
						-- 		winbar = {},
					},
					globalstatus = vim.o.laststatus == 3,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },

					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
                        -- stylua: ignore
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ utils.pretty_path { modified_hl = "MatchParen" } },
						-- {'filename'},
					},
					lualine_x = {
                        -- stylua: ignore
                        {
                            function() return require("lualine").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                            color = { fg = function() return utils.get_hl_colors("Statement").fg end },
                        },
                        -- stylua: ignore
                        -- {
                        -- 	function() return require("noice").api.status.mode.get() end,
                        -- 	cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        -- 	color = { fg = function() return utils.get_hl_colors("Constant").fg end },
                        -- },
                        -- stylua: ignore
                        {
                            function() return "  " .. require("dap").status() end,
                            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                            color = { fg = function() return utils.get_hl_colors("Debug").fg end },
                        },
                        -- stylua: ignore
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = { fg = function() return utils.get_hl_colors("Special").fg end },
                        },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						-- Show commands like 
						{
							function() vim.o.showcmdloc = "statusline" return " " .. "%S" end,
							cond = function () return vim.o.showcmd end,
						},
						{ "location", separator = "", padding = { left = 0, right = 1 } },
						{ "progress", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date "%R"
						end,
					},
					-- stylua: ignore
				},
				extensions = { "nvim-tree", "lazy", "neo-tree" },
			}
			return opts
		end,
	},
}

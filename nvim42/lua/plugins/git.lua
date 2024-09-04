return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local options = {
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},

				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function opts(desc)
						return { buffer = bufnr, desc = desc }
					end

					local map = vim.keymap.set

					map("n", "<leader>rh", gs.reset_hunk, opts "Reset Hunk")
					map("n", "<leader>ph", gs.preview_hunk, opts "Preview Hunk")
					map("n", "<leader>gb", gs.blame_line, opts "Blame Line")
				end,
			}

			return options
		end,
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig", -- Open the configuration file
			"LazyGitCurrentFile", -- start a floating window
			"LazyGitFilter", -- Open project commits in floating window.
			"LazyGitFilterCurrentFile", -- Open buffer commits
		},
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "Launch LazyGit" },
		},
		-- optional for floting window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g.lazygit_floating_window_winblend = 0
			vim.cmd "highlight! clear LazyGitBorder"
			vim.cmd "highlight! clear LazyGitFloat"
			vim.cmd "highlight! link LazyGitBorder NotifyINFOTitle"
			vim.cmd "highlight! link LazyGitFloat Title"
		end,
	},
}

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup {
				signs = {
					add = { text = "▎" },
					change = { text = "┃" },
					delete = { text = "󰍵" },
					topdelete = { text = "" },
					changedelete = { text = "󱕖" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "▎" },
					change = { text = "┃" },
					delete = { text = "󰍵" },
					topdelete = { text = "" },
					changedelete = { text = "┆" },
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal { "]c", bang = true }
						else
							gs.nav_hunk "next"
						end
					end, "Next Hunk")
					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal { "[c", bang = true }
						else
							gs.nav_hunk "prev"
						end
					end, "Prev Hunk")
					map("n", "]H", function()
						gs.nav_hunk "last"
					end, "Last Hunk")
					map("n", "[H", function()
						gs.nav_hunk "first"
					end, "First Hunk")
					map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
					map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
					map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
					map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
					map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
					map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
					map("n", "<leader>ghb", function()
						gs.blame_line { full = true }
					end, "Blame Line")
					map("n", "<leader>ghB", function()
						gs.blame()
					end, "Blame Buffer")
					map("n", "<leader>ghd", gs.diffthis, "Diff This")
					map("n", "<leader>ghD", function()
						gs.diffthis "~"
					end, "Diff This ~")
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				end,
			}
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

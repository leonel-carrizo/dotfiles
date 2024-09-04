local have_make = vim.fn.executable "make" == 1
local have_cmake = vim.fn.executable "cmake" == 1

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	cmd = "Telescope",
	opts = {
		defaults = {
			prompt_prefix = "   ",
			selection_caret = " ",
			entry_prefix = " ",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.55,
					preview_cutoff = 0,
				},
				width = 0.87,
				height = 0.80,
			},
			mappings = {
				n = { ["q"] = require("telescope.actions").close },
				i = { ["<C-u>"] = false },
			},
		},
		extensions_list = { "fzf", "live_grep_args" },
		extensions = {},
		pickers = {
			colorscheme = { enable_preview = true },
			find_files = {
				mappings = {
					n = {
						["cd"] = function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							local dir = vim.fn.fnamemodify(selection.path, ":p:h")
							require("telescope.actions").close(prompt_bufnr)
							-- Depending on what you want put `cd` global dir, `lcd` cd file selected, `tcd` current tab.
							vim.cmd(string.format("silent cd %s", dir))
						end,
					},
				},
			},
		},
	},

	config = function(_, opts)
		local telescope = require "telescope"
		telescope.setup(opts)
		-- load extensions
		for _, ext in ipairs(opts.extensions_list) do
			telescope.load_extension(ext)
		end
	end,

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
		{
			-- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.1.0",
			config = function()
				require("telescope").load_extension "live_grep_args"
			end,
		},
		{
			-- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
			"nvim-telescope/telescope-fzf-native.nvim",
			build = have_make and "make"
				or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			enabled = have_make or have_cmake,
			config = function()
				require("telescope").load_extension "fzf"
			end,
		},
	},

	keys = {
		{ "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
		{ "<leader><space>", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep (cwd)." },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope list files (cwd), respects .gitignore" },
		{ "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "telescope find in current buffer" },
		{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "telescope find oldfiles" },
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "telescope git commits" },
		{ "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "telescope git status" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "telescope show diagnostics signs" },
		{
			"<leader>fa",
			"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
			desc = "telescope find all files",
		},
		{ "<leader>sH", "<cmd>Telescope help_tags<CR>", desc = "telescope help page" },
		{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
		{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		{ "<leader>s:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{
			"<leader>tt",
			function()
				require("telescope.builtin").colorscheme { enable_preview = true }
			end,
			desc = "Colorscheme with Preview",
		},
		{
			"<leader>sg",
			function()
				local lga_shortcuts = require "telescope-live-grep-args.shortcuts"
				lga_shortcuts.grep_word_under_cursor()
			end,
			desc = "Grep word under cursor",
		},
		{
			"<leader>fh",
			function()
				local path_util = require "utils.paths_utils"
				require("telescope.builtin").find_files {
					follow = true,
					no_ignore = true,
					hidden = true,
					cwd = path_util.root_dir { home = true },
				}
			end,
			desc = "Find files in Home Directory",
		},
	},
}

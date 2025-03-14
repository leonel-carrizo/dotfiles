return {
	-- header 42London
	-- {
	-- 	dir = "$HOME/.vim/plugin/stdheader.vim",
	-- 	lazy = true,
	-- 	cmd = "Stdheader",
	-- 	keys = {
	-- 		{ "<F1>", "<cdm>Stdheader<CR>", desc = "42 Header for C Files." },
	-- 	},
	-- 	ft = { "c", "Makefile" },
	-- 	config = function()
	-- 		vim.cmd "source $HOME/.vim/plugin/stdheader.vim"
	-- 	end,
	-- },
	-- linter
	{
		"vinicius507/norme.nvim",
		cmd = "NormeToggle",
		keys = {
			{
				"<leader>cn",
				"<cmd>NormeToggle<CR>",
				mode = { "n", "v" },
				desc = "Toggle Norminette linter on C/CPP files.",
			},
		},
		ft = { "c" },
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("null-ls").setup()
			require("norme").setup()
		end,
	},
	-- formater
	{
		"cacharle/c_formatter_42.vim",
		cmd = "CFormatter42",
		keys = {
			{ "<F2>", "<cmd>CFormatter42<CR>", mode = { "n", "v" }, desc = "Format C files for Norminette." },
		},
		ft = { "c", "cpp" },
	},
}

return
{
	-- header 42London
	{
		dir = "$HOME/.vim/plugin/stdheader.vim",
		lazy = true,
		cmd = "Stdheader",
		keys =
		{ "<F1>", "<cdm>Stdheader<CR>", mode = 'n', remap = true, silent = true, desc = "42 Header for C Files." },
		ft = { "c", "Makefile" },
		config = function()
			vim.cmd("source $HOME/.vim/plugin/stdheader.vim")
		end
	},
	-- formater
	{

	},
	-- linter
	{

	},
}

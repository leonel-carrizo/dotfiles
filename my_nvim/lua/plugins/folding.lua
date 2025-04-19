return {
	{
		-- "kevinhwang91/nvim-ufo",
		-- dependencies = "kevinhwang91/promise-async",
		-- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#minimal-configuration
		-- config = function()
		-- 	vim.o.foldcolumn = "2" -- '0' is not bad
		-- 	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		-- 	vim.o.foldlevelstart = 99
		-- 	vim.o.foldenable = true
		--
		-- 	-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		-- 	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		-- 	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		-- 	vim.keymap.set("n", "Z", function()
		-- 		local winid = require("ufo").peekFoldedLinesUnderCursor()
		-- 		if not winid then
		-- 			vim.lsp.buf.hover()
		-- 		end
		-- 	end)
		--
		-- 	require("ufo").setup {
		-- 		-- provider_selector = function(bufnr, filetype, buftype)
		-- 		-- 	return { "lsp", "indent" }
		-- 		-- end,
		-- 	}
		-- end,
	},
	{
		"luukvbaal/statuscol.nvim",
		event = { "BufWinEnter", "WinEnter", "UIEnter" },
		config = function()
			local builtin = require "statuscol.builtin"
			require("statuscol").setup {
				relculright = true,
				segments = {
					{
						text = { builtin.foldfunc, " " },
						click = "v:lua.ScFa",
						condition = { builtin.not_empty },
					},
					{
						sign = { namespace = { "signs" }, maxwidth = 2, auto = true },
						click = "v:lua.ScSa",
					},
					{
						text = { builtin.lnumfunc, " " },
						click = "v:lua.ScLa",
						condition = { true, builtin.not_empty },
					},
				},
			}
		end,
	},
}

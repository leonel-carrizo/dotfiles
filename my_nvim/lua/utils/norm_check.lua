local M = {}

function M.ToggleNormCheck()
	local enabled = vim.g.highlight_long_lines_enabled or 0

	vim.api.nvim_set_hl(0, "LongLine", {})
	if enabled == 1 then
		-- Clear the autocommand group
		vim.api.nvim_clear_autocmds { group = "highlight_long_lines" }
		-- Clear the highlight group
		vim.g.highlight_long_lines_enabled = 0
		vim.opt.list = false
		print "Norm Check deactivated"
	else
		-- Create a new autocommand group
		vim.api.nvim_create_augroup("highlight_long_lines", { clear = true })

		-- Set the autocommand
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertCharPre" }, {
			group = "highlight_long_lines",
			pattern = { "*.c", "*.h", "*.md" },
			callback = function()
				vim.fn.matchadd("LongLine", "\\%>80v.\\+", 11)
			end,
		})

		-- Set the highlight group
		vim.api.nvim_set_hl(0, "LongLine", { bg = "red", fg = "yellow", force = true })
		vim.g.highlight_long_lines_enabled = 1
		vim.opt.list = true
		print "Space Check activated"
	end
end

return M

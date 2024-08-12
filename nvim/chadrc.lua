---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
	statusline = {
	-- more opts
	order = {"mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor", "position" }, -- check stl/utils.lua file in ui repo 
	modules = {
		-- The default cursor module is override
	position = function()
		return "%#St_pos_text# %l-%c"
	end
	}
  }
}

return M

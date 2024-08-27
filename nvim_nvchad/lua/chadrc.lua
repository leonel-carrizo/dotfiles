---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyodark",
	transparency = false,
	theme_toggle = { "tokyodark", "onedark" },
	integrations = {},
	-- overriding the color of show list, NonText, specialchar
	hl_override = {
		NonText = { fg = "grey_fg2" },
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}
M.ui = {
	statusline = {
		order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor", "position" }, -- check stl/utils.lua file in ui repo
		modules = {
			position = function() -- The default cursor position module is override
				return "%#St_pos_text# %l-%c"
			end,
		},
	},
	nvdash = {
		load_on_startup = true,
	},
}
M.term = {
	hl = "Normal:term,WinSeparator:WinSeparator",
	sizes = { sp = 0.4, vsp = 0.4 },
	float = {
		relative = "editor",
		row = 0.1,
		col = 0.20,
		width = 0.6,
		height = 0.6,
		border = "single",
	},
}

return M

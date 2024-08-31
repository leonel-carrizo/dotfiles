---@class myplugin.util.lualine
local M = {}

--- Function to get the foreground and background colors of a highlight group
--- @param group string: The name of the highlight group (e.g., "Normal", "Comment")
--- @return table: A table containing the foreground (fg) and background (bg) colors in hexadecimal format
function M.get_hl_colors(group)
	-- Use vim.api.nvim_get_hl_by_name to retrieve the highlight information
	-- local hl = vim.api.nvim_get_hl_by_name(group, true)
	local hl = vim.api.nvim_get_hl(0, { name = group })

	-- Convert the colors from decimal to hexadecimal and format as strings
	local fg = hl.fg and string.format("#%06x", hl.fg) or nil
	local bg = hl.bg and string.format("#%06x", hl.bg) or nil

	return {
		fg = fg,
		bg = bg,
	}
end

-- Function to get the current working directory
function M.get_cwd()
	return vim.fn.getcwd()
end

-- Function to get the project root directory
-- You can customize the logic to identify the project root (e.g., by looking for .git, etc.)
function M.get_root(opts)
	opts = opts or { normalize = true }

	-- Example of a simple implementation to get the root directory by searching for a .git folder or similar
	local root = vim.fs.find({ ".git", "Makefile", "package.json" }, { upward = true, stop = vim.loop.os_homedir() })[1]

	-- If root is found, return its directory; otherwise, return the current working directory
	root = root and vim.fn.fnamemodify(root, ":p:h") or M.get_cwd()

	if opts.normalize then
		root = vim.fn.fnamemodify(root, ":p")
	end

	return root
end

function M.root_dir(opts)
	opts = vim.tbl_extend("force", {
		cwd = true,
		subdirectory = false,
		parent = false,
		other = false,
		home = false,
		icon = "󱉭 ",
		color = M.get_hl_colors("Statement").fg,
	}, opts or {})

	local cwd = M.get_cwd()
	local root = M.get_root { normalize = true }

	local function get_path()
		if opts.home then
			return vim.loop.os_homedir() -- Devuelve el directorio HOME
		elseif root == cwd then
			return opts.cwd and root
		elseif root:find(cwd, 1, true) == 1 then
			return opts.subdirectory and root
		elseif cwd:find(root, 1, true) == 1 then
			return opts.parent and root
		else
			return opts.other and root
		end
	end

	return get_path() or cwd
end

---@param opts? {relative: "cwd"|"root", modified_hl: string?, directory_hl: string?, filename_hl: string?, modified_sign: string?, readonly_icon: string?, length: number?}
function M.pretty_path(opts)
	opts = vim.tbl_extend("force", {
		relative = "cwd",
		modified_hl = "MatchParen",
		directory_hl = "",
		filename_hl = "Bold",
		modified_sign = "",
		readonly_icon = " 󰌾 ",
		length = 3,
	}, opts or {})

	return function(self)
		local path = vim.fn.expand "%:p" --[[@as string]]

		if path == "" then
			return ""
		end

		local root = M.get_root { normalize = true }
		local cwd = M.get_cwd()

		if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
			path = path:sub(#cwd + 2)
		else
			path = path:sub(#root + 2)
		end

		local sep = package.config:sub(1, 1)
		local parts = vim.split(path, "[\\/]")

		if opts.length == 0 then
			parts = parts
		elseif #parts > opts.length then
			parts = { parts[1], "…", table.concat({ unpack(parts, #parts - opts.length + 2, #parts) }, sep) }
		end

		if opts.modified_hl and vim.bo.modified then
			parts[#parts] = parts[#parts] .. opts.modified_sign
			parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
		else
			parts[#parts] = M.format(self, parts[#parts], opts.filename_hl)
		end

		local dir = ""
		if #parts > 1 then
			dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
			dir = M.format(self, dir .. sep, opts.directory_hl)
		end

		local readonly = ""
		if vim.bo.readonly then
			readonly = M.format(self, opts.readonly_icon, opts.modified_hl)
		end
		return dir .. parts[#parts] .. readonly
	end
end

---@param component any
---@param text string
---@param hl_group? string
---@return string
function M.format(component, text, hl_group)
	text = text:gsub("%%", "%%%%")
	if not hl_group or hl_group == "" then
		return text
	end
	---@type table<string, string>
	component.hl_cache = component.hl_cache or {}
	local lualine_hl_group = component.hl_cache[hl_group]
	if not lualine_hl_group then
		local utils = require "lualine.utils.utils"
		---@type string[]
		local gui = vim.tbl_filter(function(x)
			return x
		end, {
			utils.extract_highlight_colors(hl_group, "bold") and "bold",
			utils.extract_highlight_colors(hl_group, "italic") and "italic",
		})

		lualine_hl_group = component:create_hl({
			fg = utils.extract_highlight_colors(hl_group, "fg"),
			gui = #gui > 0 and table.concat(gui, ",") or nil,
		}, "MY_" .. hl_group) --[[@as string]]
		component.hl_cache[hl_group] = lualine_hl_group
	end
	return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

return M

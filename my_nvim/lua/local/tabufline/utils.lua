-- Credit to: Sidhanth Rathod https://github.com/siduck
-- taken from https://github.com/NvChad/NvChad/
-- NvChad/NvChad is licensed under the GNU General Public License v3.0

vim.cmd [[
  highlight link TbBufOn Special         " Para letras buffers activos
  highlight link TbBufOnClose NormalNC   " Para el botón de cierre en el buffer activo
  highlight link TbBufOnModified CursorLineNr  " Para Boton buffers activos modificados

  highlight link TbBufOff SignColumn        " Para letras buffers inactivos
  highlight link TbBufOffClose SignColumn   " Para el botón de cierre en el buffer inactivo
  highlight link TbBufOffModified SignColumn  " Para Boton buffers inactivos modificados

  highlight link DevIconDefault NormalNC  " Enlazar con el ícono de directorio
  highlight link DevIconC DevIconCpp
  highlight link DevIconC DevIconCpp
  highlight TbNewFile guibg=#222500 guifg=#828bb8
]]

local M = {}
local api = vim.api
local fn = vim.fn
local get_opt = api.nvim_get_option_value
local strep = string.rep
local cur_buf = api.nvim_get_current_buf
local buf_name = api.nvim_buf_get_name

M.txt = function(str, hl)
	str = str or ""
	local a = "%#Tb" .. hl .. "#" .. str
	return a
end

M.btn = function(str, hl, func, arg)
	str = hl and M.txt(str, hl) or str
	arg = arg or ""
	return "%" .. arg .. "@Tb" .. func .. "@" .. str .. "%X"
end

local function filename(str)
	return str:match "([^/\\]+)[/\\]*$"
end

local btn = M.btn
local txt = M.txt

local function new_hl(group1, group2)
	local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(group1)), "fg#")
	local bg = fn.synIDattr(fn.synIDtrans(fn.hlID("Tb" .. group2)), "bg#")
	api.nvim_set_hl(0, group1 .. group2, { fg = fg, bg = bg })
	return "%#" .. group1 .. group2 .. "#"
end

-- Normalize the file name. returns just the file name.
local function gen_unique_name(oldname, index)
	for i2, nr2 in ipairs(vim.t.bufs) do
		if index ~= i2 and filename(buf_name(nr2)) == oldname then
			return fn.fnamemodify(buf_name(vim.t.bufs[index]), ":p:.")
		end
	end
end

M.style_buf = function(nr, i)
	-- add fileicon + name
	local icon = "󰈚"
	local is_curbuf = cur_buf() == nr
	local tbHlName = "BufO" .. (is_curbuf and "n" or "ff")
	local icon_hl = new_hl("DevIconDefault", tbHlName)

	local name = filename(buf_name(nr))
	name = gen_unique_name(name, i) or name
	name = (name == "" or not name) and " No Name " or name

	if name ~= " No Name " then
		local devicon, devicon_hl = require("nvim-web-devicons").get_icon(name)

		if devicon then
			icon = devicon
			icon_hl = new_hl(devicon_hl, tbHlName)
		end
	end

	-- padding around bufname; 15= maxnamelen + 2 icon & space + 2 close icon
	local pad = math.floor((23 - #name - 5) / 2)
	pad = pad <= 0 and 1 or pad

	local maxname_len = 15
	local sep = M.txt(" ", tbHlName)

	name = string.sub(name, 1, 12) .. (#name > maxname_len and "..." or "")
	name = M.txt(" " .. name, tbHlName)

	name = strep(sep, 1) .. (icon_hl .. icon .. name)

	local close_btn = btn(" 󰖭 ", nil, "KillBuf", nr)
	name = btn(name, nil, "GoToBuf", nr)

	-- modified bufs icon or close icon
	local mod = get_opt("mod", { buf = nr })
	local cur_mod = get_opt("mod", { buf = 0 })

	-- color close btn for focused / hidden  buffers
	if is_curbuf then
		close_btn = cur_mod and txt("  ", "BufOnModified") or txt(close_btn, "BufOnClose")
	else
		close_btn = mod and txt("  ", "BufOffModified") or txt(close_btn, "BufOffClose")
	end

	name = txt(name .. close_btn, "BufO" .. (is_curbuf and "n" or "ff"))

	return name
end

return M

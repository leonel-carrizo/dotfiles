-- Credit to: Sidhanth Rathod https://github.com/siduck
-- taken from https://github.com/NvChad/NvChad/
-- NvChad/NvChad is licensed under the GNU General Public License v3.0

local api = vim.api
local fn = vim.fn
local g = vim.g

-- dofile(vim.g.base46_cache .. "tbline")

local txt = require("local.tabufline.utils").txt
local btn = require("local.tabufline.utils").btn
local strep = string.rep
local style_buf = require("local.tabufline.utils").style_buf
local cur_buf = api.nvim_get_current_buf
local config = require("local.tabufline.options").tabufline

---------------------------------------------------------- btn onclick functions ----------------------------------------------

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"

vim.cmd [[
   function! TbKillBuf(bufnr,b,c,d) 
        call luaeval('require("local.tabufline").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.cmd "function! TbNewTab(a,b,c,d) \n tabnew \n endfunction"
vim.cmd "function! TbNewBuf(a,b,c,d) \n enew \n endfunction"
vim.cmd "function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"
vim.cmd "function! TbCloseAllBufs(a,b,c,d) \n lua require('local.tabufline').closeAllBufs() \n endfunction"
vim.cmd "function! TbToggle_theme(a,b,c,d) \n lua require('neo-tree.command').execute({toggle = true}) \n endfunction"
vim.cmd "function! TbToggleTabs(a,b,c,d) \n let g:TbTabsToggled = !g:TbTabsToggled | redrawtabline \n endfunction"

-------------------------------------------------------- functions ------------------------------------------------------------

local function getNvimTreeWidth()
	for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
		if vim.bo[api.nvim_win_get_buf(win)].ft == "neo-tree" then
			return api.nvim_win_get_width(win) + 1
		end
	end
	return 0
end

------------------------------------- modules -----------------------------------------
local M = {}

local function available_space()
	local str = ""

	for _, key in ipairs(config.order) do
		if key ~= "buffers" then
			str = str .. M[key]()
		end
	end

	local modules = api.nvim_eval_statusline(str, { use_tabline = true })
	return vim.o.columns - modules.width
end

M.treeOffset = function()
	local str = ""
	-- verificar si el offset es la primera posicion.
	for _, key in ipairs(config.order) do
		if key ~= "treeOffset" then
			str = str .. M[key]()
		else
			break
		end
	end
	-- si no es la primera posicion en config.order. calcular el ancho de las anteriores
	local modules = api.nvim_eval_statusline(str, { use_tabline = true })
	-- si es la primera devolver el ancho.
	return "%#Normal#" .. strep(" ", getNvimTreeWidth() - modules.width)
end

M.buffers = function()
	local buffers = {}
	local has_current = false -- have we seen current buffer yet?

	for i, nr in ipairs(vim.t.bufs) do
		if ((#buffers + 1) * 23) > available_space() then
			if has_current then
				break
			end

			table.remove(buffers, 1)
		end

		has_current = cur_buf() == nr or has_current
		table.insert(buffers, style_buf(nr, i))
	end

	return table.concat(buffers) .. M.btn_new() .. txt("%=", "Fill") -- buffers + empty space
end

g.TbTabsToggled = 0

M.tabs = function()
	local result, tabs = "", fn.tabpagenr "$"

	if tabs > 1 then
		for nr = 1, tabs, 1 do
			local tab_hl = "TabO" .. (nr == fn.tabpagenr() and "n" or "ff")
			result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
		end

		local new_tabtn = btn(" 󰝜 ", "TabNewBtn", "NewTab")
		local tabstoggleBtn = btn(" 󰅂 ", "TabTitle", "ToggleTabs")
		local small_btn = btn(" 󰅁 ", "TabTitle", "ToggleTabs")

		return g.TbTabsToggled == 1 and small_btn or new_tabtn .. tabstoggleBtn .. result
	end

	local new_tabtn = btn(" 󰝜 ", "TabNewBtn", "NewTab")
	return new_tabtn
end

M.btn_close = function()
	local closeAllBufs = btn(" 󱎘 ", "CloseAllBufsBtn", "CloseAllBufs")
	return closeAllBufs
end

M.btn_files = function ()
	local files_tree = btn("    ", "BufOn", "Toggle_theme")
	return files_tree
end

M.btn_new = function ()
	local new_file = btn(" 󰎝 ", "NewFile", "NewBuf")
	return new_file
end

return function()
	local result = {}

	if config.modules then
		for key, value in pairs(config.modules) do
			M[key] = value
		end
	end

	for _, v in ipairs(config.order) do
		table.insert(result, M[v]())
	end

	return table.concat(result)
end

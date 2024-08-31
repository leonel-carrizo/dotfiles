local M = {}
local map = vim.keymap.set

local function apply(curr, win)
	local newName = vim.trim(vim.fn.getline ".")
	vim.api.nvim_win_close(win, true)

	if #newName > 0 and newName ~= curr then
		local params = vim.lsp.util.make_position_params()
		params.newName = newName

		vim.lsp.buf_request(0, "textDocument/rename", params)
	end
end

function M.rename()
	local currName = vim.fn.expand "<cword>" .. " "

	local win = require("plenary.popup").create(currName, {
		title = "Renamer",
		style = "minimal",
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		relative = "cursor",
		borderhighlight = "RenamerBorder",
		titlehighlight = "RenamerTitle",
		focusable = true,
		width = 25,
		height = 1,
		line = "cursor+2",
		col = "cursor-1",
	})

	vim.cmd "normal A"
	vim.cmd "startinsert"

	map({ "i", "n" }, "<Esc>", "<cmd>q<CR>", { buffer = 0 })

	map({ "i", "n" }, "<CR>", function()
		apply(currName, win)
		vim.cmd.stopinsert()
	end, { buffer = 0 })
end

--@param opts? lsp.Client.filter
function M.get_clients(opts)
	local ret = {} ---@type vim.lsp.Client[]
	if vim.lsp.get_clients then
		ret = vim.lsp.get_clients(opts)
	else
		---@diagnostic disable-next-line: deprecated
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			---@param client vim.lsp.Client
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param from string
---@param to string
---@param rename? fun()
function M.on_rename(from, to, rename)
	local changes = {
		files = { {
			oldUri = vim.uri_from_fname(from),
			newUri = vim.uri_from_fname(to),
		} },
	}

	local clients = M.get_clients()
	for _, client in ipairs(clients) do
		if client.supports_method "workspace/willRenameFiles" then
			local resp = client.request_sync("workspace/willRenameFiles", changes, 1000, 0)
			if resp and resp.result ~= nil then
				vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
			end
		end
	end

	if rename then
		rename()
	end

	for _, client in ipairs(clients) do
		if client.supports_method "workspace/didRenameFiles" then
			client.notify("workspace/didRenameFiles", changes)
		end
	end
end

return M

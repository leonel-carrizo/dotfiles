--- get the path over the system
local function set_path()
	local os_name = io.popen("uname"):read "*l"

	if os_name == "Darwin" then
		return "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Home/"
	elseif os_name == "Linux" then
		return "$HOME/Documents/home/"
	else
		return nil
	end
end

return {
	"obsidian-nvim/obsidian.nvim",
	event = "VeryLazy",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	-- README: https://github.com/obsidian-nvim/obsidian.nvim?tab=readme-ov-file#configuration-options
	opts = {
		workspaces = {
			{
				name = "Home",
				path = set_path(),
			},
		},
		notes_subdir = "00 Inbox",

		new_notes_location = "notes_subdir",

		ui = { enable = false },

		---@return table
		frontmatter = {
			enabled = true,
			func = function(note)
				-- Add the title of the note as an alias.
				if note.title then
					note:add_alias(note.title)
				end
				if note.id == note.title or note.id == nil then
					note.id = tostring(os.date("%a%d%b%Y%H%M", os.time()))
				end
				local date = os.date("%d-%m-%Y %H:%M:%S", os.time())
				local out = { id = note.id, date = date, aliases = note.aliases, tags = note.tags }

				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end

				return out
			end,
		},
		templates = {
			subdir = "03 Templates",
			date_format = "%d-%m-%Y",
			time_format = "%H:%M:%S",
		},

		-- Customize how note IDs are generated.
		-- return string DayMonthYeartime
		---@return string
		note_id_func = function()
			local dateFormatted = os.date("%a%d%b%Y%H%M", os.time())
			return tostring(dateFormatted)
		end,

		---@diagnostic disable: luadoc-miss-type-name, undefined-doc-name, undefined-doc-param
		---@param opts { path: string, label: string, id: string|integer|?, anchor: obsidian.note.HeaderAnchor|?, block: obsidian.note.Block|? }
		---@return string
		wiki_link_func = function(opts)
			local file_name = require("obsidian.note").fname(opts)
			return string.format("[[%s|%s]]", file_name, opts.label)
		end,

		-- If file name is not given, return <Note>_<4random_chars>
		---@param spec { id: string, dir: obsidian.Path, title: string|? }
		---@return string|obsidian.Path The full path to the new note.
		note_path_func = function(spec)
			local filename = ""
			if spec.title ~= nil then
				local clean_title = spec.title:gsub(" ", "_"):gsub("[^A-Za-z0-9-]", "_")
				filename = clean_title
			else
				local random_chars = ""
				for _ = 1, 4 do
					random_chars = random_chars .. string.char(math.random(65, 90))
				end
				filename = "Note" .. "_" .. random_chars .. "_" .. tostring(spec.id)
			end
			local path = spec.dir / filename
			return path:with_suffix ".md"
		end,

		image_name_func = function()
			local dateFormatted = os.date("%a%d%b%Y%H%M", os.time())
			return "Img" .. dateFormatted
		end,

		attachments = {
			folder = "/02 Archive/Files_Assets",

			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				-- local name_no_ext = path.stem
				-- local extracted_part = name_no_ext:match(".*_(.*)")
				return string.format("![[./%s]]", path) -- Easier compatibility with image.nvim
			end,
		},
		---@class obsidian.config.CallbackConfig
		---
		---Runs right after setup
		---@field post_setup? fun()
		---
		---Runs when entering a note buffer.
		---@field enter_note? fun(note: obsidian.Note)
		---
		---Runs when leaving a note buffer.
		---@field leave_note? fun(note: obsidian.Note)
		---
		---Runs right before writing a note buffer.
		---@field pre_write_note? fun(note: obsidian.Note)
		---
		---Runs anytime the workspace is set/changed.
		---@field post_set_workspace? fun(workspace: obsidian.Workspace)
		callbacks = {
			enter_note = function()
				-- for opening the attached files 
				vim.ui.open = (function(overridden)
					return function(uri, opt)
						if vim.endswith(uri, ".png") then
							vim.cmd("edit " .. uri)
							return
						elseif vim.endswith(uri, ".pdf") then
							opt = { cmd = { "zathura" } }
						end
						return overridden(uri, opt)
					end
				end)(vim.ui.open)
			end,
		},
		legacy_commands = false,
	},
}

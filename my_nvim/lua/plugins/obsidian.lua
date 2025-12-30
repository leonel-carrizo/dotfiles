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

		-- Customize behavior when use `:ObsidianFollowLink` on a link to an external
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			vim.fn.jobstart { "open", url } -- Mac OS
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			-- vim.ui.open(url) -- need Neovim 0.10.0+
		end,

		image_name_func = function()
			local dateFormatted = os.date("%a%d%b%Y%H%M", os.time())
			return "Img" .. dateFormatted
		end,

		attachments = {
			img_folder = "02 Archive/Files_Assets",

			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				-- local name_no_ext = path.stem
				-- local extracted_part = name_no_ext:match(".*_(.*)")
				return string.format("![[./%s]]", path) -- Easier compatibility with image.nvim
			end,
		},
		legacy_commands = false,
	},
}

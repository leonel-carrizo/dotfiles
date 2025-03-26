return {
	"epwalsh/obsidian.nvim",
	event = "VeryLazy",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	-- More settings on :
	-- README: https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#configuration-options
	-- Default: https://github.com/epwalsh/obsidian.nvim/blob/main/lua/obsidian/config.lua#L302
	opts = {
		workspaces = {
			{
				name = "Home",
				path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Home/",
			},
		},
		notes_subdir = "00 inbox",
		new_notes_location = "notes_subdir",
		-- disable_frontmatter = true,
		templates = {
			subdir = "Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},
		completion = {
			nvim_cmp = true,
			min_char = 3,
		},
		-- Customize how note IDs are generated given an optional title.
		-- Create note IDs format with a file name and date. <file_name>_<date>
		-- If file name is not given, return <no_name>_<4 random_chars><date>
		---@param title string|?
		---@return string
		note_id_func = function(title)
			local timestamp = os.time()
			local dateFormatted = os.date("%a%d%b%Y%H%M", timestamp)
			local filename = ""

			if title ~= nil then
				local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				filename = clean_title .. "_" .. dateFormatted
			else
				local random_chars = ""
				for _ = 1, 4 do
					random_chars = random_chars .. string.char(math.random(65, 90))
				end
				filename = "no_name_" .. random_chars .. "_" .. dateFormatted
			end

			return filename
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

		image_name_func = function ()
			local dateFormatted = os.date("%a%d%b%Y%H%M", os.time())
			return "Img" .. dateFormatted
		end,

		attachments = {
			img_folder = "Archive/Files_Assets",

			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				local name_no_ext = path.stem
				-- local extracted_part = name_no_ext:match(".*_(.*)")
				return string.format("![[%s|%s]]", path.name, name_no_ext)
			end,
		},

		mappings = {
			-- Go to the linked file
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- toggle check-boxes
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "Obsidian toggle check-boxes" },
			},
			-- Paste Imnage from Clipboard
			["<leader>op"] = {
				action = ":ObsidianPasteImg <CR>",
				opts = { desc = "Obsidian Paste Image" }
			},
			-- Search in the vault
			["<leader>os"] = {
				action = ":ObsidianSearch <CR>",
				opts = { desc = "Obsidian Search in vault" }
			},
			-- create new note
			["<leader>on"] = {
				action = ":ObsidianNew <CR>",
				opts = { desc = "Obsidian Create New Note" }
			},
		},
	},
}

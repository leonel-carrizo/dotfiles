local options = {
	sources = { "filesystem", "buffers", "git_status" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
	default_component_configs = {
		indent = {
			with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		modified = {
			symbol = "󰤌",
		},
		git_status = {
			symbols = {
				unstaged = "󰮞",
				staged = "",
			},
		},
	},
	window = {
		position = "left", -- default left
		width = 25,
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
			-- ["<space>"] = "none",
			["Y"] = {
				function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.setreg("+", path, "c")
				end,
				desc = "Copy Path to Clipboard",
			},
			["O"] = {
				function(state)
					require("lazy.util").open(state.tree:get_node().path, { system = true })
				end,
				desc = "Open with System Application",
			},
			["P"] = { "toggle_preview", config = { use_float = false } },
		},
	},
	git_status = {
		window = {
			position = "float",
		}
	}
}

return options

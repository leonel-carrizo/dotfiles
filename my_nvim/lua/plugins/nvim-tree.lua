return {
	-- file managing , picker etc
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
		filters = { dotfiles = false },
  		disable_netrw = true,
  		hijack_cursor = true,
  		sync_root_with_cwd = false,
  		update_focused_file = {
  		  enable = true,
  		  update_root = true,
  		},
  		view = {
  		  width = 30,
  		  preserve_window_proportions = true,
  		},
  		renderer = {
		  group_empty = true,
  		  root_folder_label = false,
  		  highlight_git = true,
  		  indent_markers = { enable = true },
  		  icons = {
  		    glyphs = {
  		      default = "󰈚",
  		      folder = {
  		        default = "",
  		        empty = "",
  		        empty_open = "",
  		        open = "",
  		        symlink = "",
  		      },
  		      git = { unmerged = "" },
  		    },
  		  },
  		},
	 },
	-- config = function (_, opts)
			-- on_atach = function()
				-- somethin
		--end
}

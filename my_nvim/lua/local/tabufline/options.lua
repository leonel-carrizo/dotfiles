-- Credit to: Sidhanth Rathod https://github.com/siduck
-- taken from https://github.com/NvChad/NvChad/
-- NvChad/NvChad is licensed under the GNU General Public License v3.0

local options = {
		-- lazyload it when there are 1+ buffers
	tabufline = {
			enabled = true,
			lazyload = true,
			order = { "treeOffset", "buffers", "tabs", "btns" },
			modules = nil,
	},
}

return options

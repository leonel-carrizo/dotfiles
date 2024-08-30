-- Credit to: Sidhanth Rathod https://github.com/siduck
-- taken from https://github.com/NvChad/NvChad/
-- NvChad/NvChad is licensed under the GNU General Public License v3.0

local options = {
	term = {
	  winopts = { number = false, relativenumber = false },
	  sizes = { sp = 0.4, vsp = 0.5, ["bo sp"] = 0.4, ["bo vsp"] = 0.5 },
	  float = {
		relative = "editor",
		row = 0.05,
		col = 0.10,
		width = 0.8,
		height = 0.8,
		border = "rounded",
	  },
	},
  }
  return options

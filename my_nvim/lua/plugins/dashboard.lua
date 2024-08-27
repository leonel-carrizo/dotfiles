return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New File", "<cmd>ene<CR>"),
			dashboard.button("e", "󰙅  Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("f", "󰱼  Find File CWD", "<cmd>Telescope find_files<CR>"),
			dashboard.button("h", "󱂶  Find in Home Directory", "<cmd>lua require('telescope.builtin').find_files({hidden=true, cwd=require('utils.paths_utils').root_dir({home = true})})<CR>"),
			dashboard.button("o", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("k", "󰌓  Find a Keymap", "<cmd>Telescope keymaps<CR>"),
			dashboard.button("r", "󰁯  Restore Session For Current Directory", "<cmd>lua require('persistence').load()<CR>"),
			dashboard.button("s", "  Select a session to restore", "<cmd>lua require('persistence').select()<CR>"),
			dashboard.button("l", "󰒲  Open Lazy pluging manager", "<cmd>Lazy<CR>"),
			dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}

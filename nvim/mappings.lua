require "nvchad.mappings"

local map = vim.keymap.set

---- workspace
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "going fast to normal mode" })
map({ "n", "i", "v" }, "<C-q>", "<cmd> x <cr>", { desc = "closing fast" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Saving on any mode" })
map("i", "<C-x>", "<C-o>x", { desc = "delete on insert mode" })
map("v", "<C-c>", '"+Y', {desc = "Copy to clipboard" })

-- kindof linter 42 norm (development on going)
map({ "n", "i", "v" }, "<F5>", function()
  require("configs.norm_check").ToggleNormCheck()
end, { desc = "show spaces and long lines in  C" })

---- terminals
map({ "n", "t" }, "<A-t>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })
-- htop
map({ "n", "t" }, "<A-o>", function ()
	require("nvchad.term").toggle {
		pos = "float",
		float_opts = {
			relative = "editor",
			style = "minimal",
      		row = 0.05,
      		col = 0.10,
      		width = 0.8,
      		height = 0.8,
      		border = "rounded",
		},
		cmd = "htop",
		id = "floatTermHtop",
		external = true,
		clear_cmd = true
	}
end, { desc = "Open Htop on toggle float term." })
-- LazyGit
map({"n", "t"}, "<leader>lg", "<cmd>LazyGit<cr>", {desc = "LazyGit" })

-- formating files
map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true }, function()
    -- print "file formatted!, run: conformInfo for more."
    vim.cmd "edit!"
  end)
end, { desc = "General Format file" })

---- theme toggling
map("n", "<leader>tt", function ()
	require("base46").toggle_theme()
end, { desc = "Toggle theme." })

map("n", "<leader>t.", function ()
	require("base46").toggle_transparency()
end, { desc = "Toggle transparency." })

-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })


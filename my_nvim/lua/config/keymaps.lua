local map = vim.keymap.set

---- workspace
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map({"i", "v", "t"}, "jk", "<ESC>", { desc = "going fast to normal mode" })
map({ "n", "i", "v", "t" }, "<C-q>", "<cmd> q <cr>", { desc = "Fast Closing." })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Saving on any mode" })
map("i", "<C-x>", "<C-o>x", { desc = "delete on insert mode" })
map("v", "<C-c>", '"+Y', { desc = "Copy to clipboard" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- navegation
map({"i", "v"}, "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map({"i", "v"}, "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-Left>", "<C-w>h", { remap = true, desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-Right>", "<C-w>l", { remap = true, desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

--preserve the copied text after pasting
map("x", "<leader>p", [["_dP]])

-- move btext blocks
map("v", "<C-J>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted block down" })
map("v", "<C-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted block down" })
map("v", "<C-K>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted line up" })
map("v", "<C-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted line up" })

-- for replacing 
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Quick replacing words on editing file."})

-- kindof linter 42 norm (development on going)
map({ "n", "i", "v" }, "<F5>", function()
	require("utils.norm_check").ToggleNormCheck()
end, { desc = "show spaces and long lines in  C" })

-- TERMINALS
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

	-- toggleable
map({ "n", "t" }, "<A-v>", function()
	require("local.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
	require("local.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })
	-- flaot toggleable
map({ "n", "t" }, "<A-i>", function()
	require("local.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Float Toggle Terminal." })

map({ "n", "t" }, "<A-o>", function()
	require("local.term").toggle({
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
		clear_cmd = true,
	})
end, { desc = "Open Htop on toggle float term." })

	-- Attached
map("n", "<leader>h", function()
	require("local.term").new({ pos = "sp" })
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
	require("local.term").new { pos = "vsp" }
  end, { desc = "terminal new vertical window" })


-- formating files
map("n", "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
		-- print "file formatted!, run: conformInfo for more."
end, { desc = "General Format file" })

-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

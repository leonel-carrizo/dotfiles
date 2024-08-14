require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "going fast to normal mode" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Saving on any mode" })

-- map({ "n", "i", "v" }, "<F5>", "<cmd> set list! <cr>")
map({ "n", "i", "v" }, "<C-q>", "<cmd> x <cr>", { desc = "closing fast" })
map("i", "<C-x>", "<C-o>x", { desc = "delete on insert mode" })
map({ "n", "i", "v" }, "<F5>", function()
	require("configs.norm_check").ToggleNormCheck()
end, { desc = "show spaces and long lines in  C" })

map({ "n", "t" }, "<A-t>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

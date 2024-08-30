local map = vim.keymap.set

------------------------------ Workspace --------------------------------------
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", ";", ":", { desc = "Enter command mode" })
map({"i", "v", "t"}, "jk", "<ESC>", { desc = "Quickly go to normal mode" })
map({ "n", "i", "v" }, "<C-q>", "<cmd>q<cr>", { desc = "Fast close" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save in any mode" })
map("i", "<C-x>", "<C-o>x", { desc = "Delete in insert mode" })
map("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy entire file to clipboard" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative numbers" })

------------------------------ Comment ----------------------------------------
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

------------------------------ Navigation -------------------------------------
map({"i", "v"}, "<C-b>", "<ESC>^i", { desc = "Move to beginning of line" })
map({"i", "v"}, "<C-e>", "<End>", { desc = "Move to end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-Left>", "<C-w>h", { remap = true, desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-Right>", "<C-w>l", { remap = true, desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

---------------------------- Preserve Pasted Text -----------------------------
map("x", "<leader>p", [["_dP]], { desc = "Preserve yanked text after pasting" })

------------------------------ Move Text Blocks -------------------------------
map("v", "<C-J>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted block down" })
map("v", "<C-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted block down" })
map("v", "<C-K>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted line up" })
map("v", "<C-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted line up" })

----------------------------- Quick Replace -----------------------------------
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Quick replace word under cursor" })

------------------------------ 42 Norm Check ----------------------------------
map({ "n", "i", "v" }, "<F5>", function()
    require("utils.norm_check").ToggleNormCheck()
end, { desc = "Toggle display of spaces and long lines in C" })

---------------------------- Format Files -------------------------------------
map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

------------------------------ WhichKey ---------------------------------------
map("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "Show all keymaps" })

map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "WhichKey query lookup" })

------------------------------ Tabufline --------------------------------------
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })

map("n", "<tab>", function()
    require("local.tabufline").next()
end, { desc = "Go to next buffer" })

map("n", "<S-tab>", function()
    require("local.tabufline").prev()
end, { desc = "Go to previous buffer" })

map("n", "<leader>bq", function()
    require("local.tabufline").close_buffer()
end, { desc = "Close buffer" })

---------------------------- Rename Under Cursor ------------------------------
map("n", "<leader>rm", function()
    require("utils.lsprenamer").rename()
end, { desc = "Rename word under cursor" })


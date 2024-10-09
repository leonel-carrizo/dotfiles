-- Aliases for accessing options
local o = vim.o
local g = vim.g
local opt = vim.opt

------------------------------ Global Options --------------------------------
-- disable some default providcers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.toggle_theme_icon = "   "
g.user42 = "lcarrizo"
g.mail42 = "lcarrizo@student.42london.com"

------------------------------ User Interface --------------------------------
o.mouse = "a"
o.termguicolors = true
o.cursorline = true
o.cursorlineopt = "both" -- Enable cursorline
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.wrap = false
o.numberwidth = 4
o.nu = true
o.relativenumber = true

------------------------------ Editing Behavior ------------------------------
o.autoindent = true
o.smartindent = true
o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0

------------------------------ Performance -----------------------------------
o.timeoutlen = 400
o.ttimeoutlen = 0
o.updatetime = 250
o.swapfile = false
o.backup = false
o.undodir = os.getenv "HOME" .. "/.vim/undodir"
o.undofile = true

------------------------------ Clipboard -------------------------------------
o.clipboard = "unnamedplus"

------------------------------ Miscellaneous ---------------------------------
-- Interval for writing the swap file to disk, also used by gitsigns
-- o.scrolloff = 8

------------------------------ Hidden Editing Characters ---------------------
opt.listchars = {
	eol = "↓",
	space = "·",
	trail = "●",
	tab = "―― ",
	extends = ">",
	precedes = "<",
}
opt.fillchars = { eob = " " }
opt.whichwrap:append "<>[]hl"
opt.shortmess:append "sI" -- Disable nvim intro

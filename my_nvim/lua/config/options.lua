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
o.guicursor = "n-v-c-sm:block-blinkon500-blinkoff500,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
o.cursorline = true
o.cursorlineopt = "both" -- Enable cursorline
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.wrap = false
o.numberwidth = 1
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
o.timeoutlen = 500
o.ttimeoutlen = 50
o.updatetime = 500
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
	eol = "↵",
	space = "‧",
	nbsp = "☠",
	tab = "╾─╼",
	trail = "●",
	multispace = "-∘",
	extends = "⇛",
	precedes = "⇚",
}
opt.fillchars = {
	eob = "☠",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = " ",
	fold = " ",
}
opt.whichwrap:append "<>[]hl"
opt.shortmess:append "sI" -- Disable nvim intro
opt.conceallevel = 1 -- for obsidian change how to show text
opt.showcmd = false

----------------------------- option for folding (statuscol.nvim) ------------
o.foldenable = true
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = ""
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99

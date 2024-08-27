local o = vim.o
local g = vim.g
local opt = vim.opt

-- disable some default providers
g.loaded_ruby_provider = 0
g.toggle_theme_icon = "   "
g.user42 = 'lcarrizo'
g.mail42 = 'lcarrizo@student.42london.com'

o.mouse = "a"
-- o.clipboard = "unnamedplus"
o.timeoutlen = 400
o.ttimeoutlen = 0
o.termguicolors = true
o.scrolloff = 8
o.cursorline = true
o.cursorlineopt = 'both' -- to enable cursorline!
o.autoindent = true
o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop=0
o.smartindent = true
-- o.numberwidth = 13
o.wrap = false
------------------------------ Sets hidden editing ----------------------------
opt.listchars = { eol = "↓", space = "·", trail = "●", tab = "―― ", extends = ">", precedes = "<" }
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.fillchars = { eob = " " }
opt.whichwrap:append "<>[]hl"
-- disable nvim intro
opt.shortmess:append "sI"

o.nu = true
o.relativenumber = true
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250


o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true

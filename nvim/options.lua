require "nvchad.options"
local o = vim.o
local opt = vim.opt
o.cursorlineopt ='both' -- to enable cursorline!
o.autoindent = true
o.expandtab = false
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop=0
------------------------------ Sets hidden editing ----------------------------
opt.listchars = { eol = "↓", space = "·", trail = "●", tab = "―― ", extends = ">", precedes = "<" }
o.wrap = false


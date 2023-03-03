local opt = vim.opt

opt.autowrite = true
opt.colorcolumn = { 80 }
opt.completeopt = { "menu", "menuone", "noinsert" }
opt.expandtab = false
opt.exrc = true
opt.fileformat = "unix"
opt.fillchars = { eob = " " }
vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]])
vim.o.foldlevelstart = 99
opt.formatoptions = "cqnj"
opt.gdefault = true
opt.ignorecase = true
opt.inccommand = "split"
opt.list = true
opt.listchars = { tab = "  ", trail = "•" }
opt.number = true
opt.numberwidth = 1
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 3
opt.secure = true
opt.shellcmdflag = "-lc"
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess = "WIFsc"
opt.showmode = false
opt.sidescrolloff = 1
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 0
opt.spell = true
opt.spelloptions = { "camel", "noplainbuffer" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%{v:relnum?v:relnum:v:lnum}│%T"
opt.suffixes = { ".swp", ".bak", ".pyc", ".out", ".aux", ".bbl", ".blg" }
opt.tabstop = 4
opt.termguicolors = true
opt.textwidth = 79
opt.timeoutlen = 600
opt.undofile = true
opt.updatetime = 100
opt.wrap = false
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.python_highlight_all = 1

if vim.fn.has("mac") == 1 then
	vim.g.python3_host_prog = "/usr/local/bin/python3"
else
	vim.g.python3_host_prog = "/usr/bin/python3"
end

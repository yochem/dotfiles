vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.python_highlight_all = 1
vim.o.autowrite = true
vim.o.colorcolumn = "80"
vim.o.conceallevel = 3
vim.o.cursorline = true
vim.o.expandtab = false
vim.o.exrc = true
vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.formatoptions = "cqnj"
vim.o.gdefault = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 0
vim.o.list = true
vim.o.number = true
vim.o.numberwidth = 1
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrolloff = 3
vim.o.secure = true
vim.o.shellcmdflag = "-Nc"
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.shortmess = "WIFsc"
vim.o.showmode = false
vim.o.sidescrolloff = 1
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 0
vim.o.spell = true
vim.o.spellsuggest = "10"
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 79
vim.o.timeoutlen = 600
vim.o.title = true
vim.o.titlestring = [[%{&modified?'● ':''}%{empty(expand('%:t'))?'nvim':expand('%:t')}]]
vim.o.undofile = true
vim.o.updatetime = 100
vim.o.wrap = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.listchars = { tab = "  ", trail = "•", multispace = "••", leadmultispace = " " }
vim.opt.spelloptions = { "camel", "noplainbuffer" }
vim.opt.suffixes = { ".swp", ".bak", ".pyc", ".out", ".aux", ".bbl", ".blg" }

if vim.fn.has("mac") == 1 then
	vim.g.python3_host_prog = "/usr/local/bin/python3"
else
	vim.g.python3_host_prog = "/usr/bin/python3"
end

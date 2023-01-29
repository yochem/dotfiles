local opt = vim.opt

opt.termguicolors = true
opt.suffixes = {'.swp', '.bak', '.pyc', '.out', '.aux', '.bbl', '.blg'}
opt.autowrite = true
opt.shellcmdflag = '-lc'
opt.completeopt = {'menu', 'menuone', 'noinsert'}
opt.textwidth = 79
opt.formatoptions = 'cqnj'
opt.exrc = true
opt.secure = true
opt.fileformat = 'unix'
opt.undofile = true
opt.mouse = 'a'
opt.timeoutlen = 600
opt.updatetime = 100

-- visible settings
opt.shortmess = 'WIFsc'
opt.spell = false
opt.showmode = false

-- window settings
opt.splitright = true
opt.splitbelow = true
opt.number = true
opt.relativenumber = true
opt.switchbuf = 'usetab,newtab'
opt.splitkeep = 'screen'


-- search settings
opt.gdefault = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.inccommand = 'split'

-- scroll behaviour
opt.foldenable = false
opt.colorcolumn = {80}
opt.scrolloff = 3
opt.wrap = false
opt.sidescrolloff = 1

-- tabs are better for accessability
opt.tabstop = 4
opt.softtabstop = 0
opt.expandtab = false
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true

-- LSP signs
opt.signcolumn = 'yes:1'
opt.numberwidth = 1
opt.fillchars = {eob = ' '}
opt.pumheight = 10

opt.statuscolumn = '%@SignCb@%s%=%T%@NumCb@%{v:relnum?v:relnum:v:lnum}│%T'

-- FZF
opt.runtimepath:append('/usr/local/opt/fzf')


-- global variables
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.python_highlight_all = 1

-- speed improvement
if vim.fn.has('mac') == 1 then
	vim.g.python3_host_prog = '/usr/local/bin/python3'
else
	vim.g.python3_host_prog = '/usr/bin/python3'
end

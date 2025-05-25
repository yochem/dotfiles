if vim.g.vscode or vim.fn.has('nvim-0.10') == 0 then
	return
end

-- require('vim._extui').enable({})

vim.g.did_install_default_menus = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python3_provider = 0

vim.loader.enable()
vim.cmd.colorscheme('mine')

-------------
-- OPTIONS --
-------------
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.o.laststatus = 0
vim.o.showmode = false
vim.o.ruler = false
vim.o.shortmess = 'WIFsclo'

vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.splitright = true

vim.o.textwidth = 79
vim.o.wrap = false

-- statuscolumn
vim.o.foldcolumn = '1'
vim.o.number = true
vim.o.numberwidth = 1
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.cursorline = true

vim.o.list = true
vim.opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '',
	foldsep = ' ',
	foldclose = ''
}
vim.opt.listchars = {
	tab = '  ',
	trail = '•',
	multispace = '••',
	leadmultispace = ' '
}

vim.o.pumheight = 10
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.jumpoptions:append({ 'view', 'stack' })

vim.o.scrolloff = 3
vim.o.sidescrolloff = 1

vim.o.title = true
vim.o.titlestring = [[%{&modified?'● ':''}%{empty(expand('%:t'))?'nvim':expand('%:t')}]]

vim.o.formatoptions = 'cqnj'

vim.o.gdefault = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.smartcase = true

vim.o.expandtab = false
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.softtabstop = -1
vim.o.tabstop = 4

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''

vim.o.spell = true
vim.o.spellsuggest = '10'
vim.opt.spelloptions = { 'camel', 'noplainbuffer' }

vim.o.autowrite = true
vim.o.undofile = true
vim.o.exrc = true
vim.o.secure = true

vim.o.shellcmdflag = '-Nc'
vim.o.timeoutlen = 400
vim.o.updatetime = 100
vim.opt.suffixes = { '.swp', '.bak', '.pyc', '.out', '.aux', '.bbl', '.blg' }

vim.o.concealcursor = 'nc'
vim.o.conceallevel = 2

vim.o.confirm = true

--------------
-- AUTOCMDS --
--------------
local augroup = vim.api.nvim_create_augroup('yochem', {})
local function on(event, callback)
	vim.api.nvim_create_autocmd(event, {
		callback = type(callback) == 'function' and callback or nil,
		command = type(callback) == 'string' and callback or nil,
		group = augroup,
	})
end

-- on('InsertEnter', 'set conceallevel=0')
-- on('InsertLeave', 'set conceallevel=2')

on('TextYankPost', function()
	vim.hl.on_yank({ timeout = 200, higroup = 'Visual' })
end)

on('BufReadPost', function()
	local mark = vim.api.nvim_buf_get_mark(0, [["]])
	if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
		vim.api.nvim_win_set_cursor(0, mark)
	end
end)

on({ 'BufRead', 'BufNewFile' }, function(opts)
	local parsers = require('nvim-treesitter.parsers')
	if parsers.get_parser_configs()[opts.match] and not parsers.has_parser(opts.match) then
		vim.schedule(function()
			vim.cmd.TSInstall(opts.match)
		end)
	end
end)

on('WinNew', function()
	if vim.fn.win_gettype(0) ~= '' then
		return
	end
	if vim.api.nvim_win_get_width(0) > 2 * 74 then
		vim.cmd.wincmd(vim.o.splitright and 'L' or 'H')
	end
end)

vim.api.nvim_create_user_command('Scratch', function()
	vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
		split = 'below',
		height = 20,
	})
	vim.cmd.startinsert()
end, {})


------------
-- REMAPS --
------------
local function cmd(command) return function() vim.cmd(command) end end
local map = vim.keymap.set

map('n', 'OO', '[<Space>', { remap = true })
map('n', 'oo', ']<Space>', { remap = true })

-- move highlighted text and auto indent
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- keep selection while visually indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- resize windows
map('n', '<S-Up>', cmd('resize +2'))
map('n', '<S-Down>', cmd('resize -2'))
map('n', '<S-Left>', cmd('vertical resize +2'))
map('n', '<S-Right>', cmd('vertical resize -2'))

-- use comma to switch windows
map('n', ',', '<c-w>')

-- Open file explorer left
map('n', '<leader>e', cmd('15Lexplore'))

-- don't move so aggressive
map('n', '<PageUp>', '10k')
map('n', '<PageDown>', '10j')

-- populate jumplist with relative jumps, otherwise move by wrapped line
map('n', 'k', [[(v:count ? "m'" . v:count : "g") . "k"]], { expr = true })
map('n', 'j', [[(v:count ? "m'" . v:count : "g") . "j"]], { expr = true })

-- reselect pasted text like |gv| does for visually selected text
map('n', 'gp', '`[v`]')

map('n', '<Esc>', vim.cmd.nohlsearch)

-- always jump exactly to mark
map('n', [[']], [[`]])

-- preserve cursor on joining lines
map('n', 'gJ', 'm`J``')

-- set mark before searching
map('n', '/', 'ms/')

-- only search in visual selection
map('x', '/', '<Esc>/\\%V')

-- don't care, just quit
map('n', 'ZZ', vim.cmd.qall)

-- close window
map('n', 'q', function()
	local success = pcall(vim.cmd.close)
	if not success then
		pcall(vim.cmd.quit)
	end
end)

map('n', 'gX', function()
	vim.ui.open(
		vim.fn.expand('<cfile>'),
		{ cmd = { 'gh', 'repo', 'view', '--web' } }
	)
end)

-- keep Q for macros
map('n', 'Q', 'q')

-- negate boolean values
map('n', '!', '<Plug>(Negate)')

map('n', 'R', cmd('source %'))

-- ignore 'scrolloff' with H and L
map('n', 'H', function()
	vim._with({ o = { scrolloff = 0 } }, function() vim.cmd('norm! H') end)
end)

map('n', 'L', function()
	vim._with({ o = { scrolloff = 0 } }, function() vim.cmd('norm! L') end)
end)

-- sensible normal mode in terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>')

-- sensible redo
map('n', '<C-r>', '<cmd>echo "Use U"<cr>')
map('n', 'U', '<C-r>')

----------
-- LAZY --
----------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
	vim.system({
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		'https://github.com/folke/lazy.nvim.git',
		lazypath
	}):wait()
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
	default = { lazy = true },
	lockfile = vim.fn.stdpath('state') .. '/lazy-lock.json',
	change_detection = { notify = false },
	install = { colorscheme = { 'mine' } },
	performance = { rtp = { reset = true } },
})

if vim.g.vscode or vim.fn.has('nvim-0.10') == 0 then
	return
end

require('vim._extui').enable({})

vim.g.did_install_default_menus = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

vim.loader.enable()
vim.cmd.colorscheme('mine')

-------------
-- OPTIONS --
-------------
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.o.laststatus = 3
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
vim.o.foldtext = ''

vim.o.spell = true
vim.o.spellsuggest = '10'
vim.opt.spelloptions = { 'camel', 'noplainbuffer' }

vim.o.autowrite = true
vim.o.hidden = false
vim.o.undofile = true
vim.o.exrc = true
vim.o.secure = true

vim.o.shellcmdflag = '-Nc'
vim.o.timeoutlen = 400
vim.o.updatetime = 100

vim.opt.path:append('**')
vim.o.wildmenu = true
vim.opt.suffixes = { '.swp', '.bak', '.pyc', '.out', '.aux', '.bbl', '.blg', '.pdf' }

vim.o.concealcursor = 'nc'
vim.o.conceallevel = 2

--------------
-- AUTOCMDS --
--------------
local augroup = vim.api.nvim_create_augroup('yochem', {})
function _G.on(event, callback, opts)
	opts = opts or {}
	if type(callback) == 'function' then
		opts.callback = callback
	else
		opts.command = callback
	end
	opts.group = opts.group or augroup
	vim.api.nvim_create_autocmd(event, opts)
end

-- on('InsertEnter', 'set conceallevel=0')
-- on('InsertLeave', 'set conceallevel=2')

on('TextYankPost', function()
	vim.hl.on_yank({ timeout = 200, higroup = 'Visual' })
end)

on('FileType', function(ev)
	if vim.bo[ev.buf].buftype ~= '' then return end
	local ok, ts = pcall(require, 'nvim-treesitter')
	if ok then
		local ft = vim.bo[ev.buf].filetype
		local is_available = vim.list_contains(ts.get_available(2), ft)
		local is_installed = vim.list_contains(ts.get_installed(), ft)
		if is_available and not is_installed then
			ts.install(ft)
		end
		if is_installed then
			vim.treesitter.start()
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end
end)

on('BufNewFile', function(ev)
	on('BufWritePre', function(ev2)
		vim.fn.mkdir(vim.fs.dirname(ev2.match), 'p')
	end, { buffer = ev.buf, once = true })
end)

on('WinNew', function()
	on({ 'BufReadPost', 'BufNewFile' }, function()
		if vim.fn.win_gettype() ~= '' then return end
		if vim.api.nvim_win_get_width(0) > 2 * 74 then
			vim.cmd.wincmd(vim.o.splitright and 'L' or 'H')
		end
	end, { once = true })
end)

vim.api.nvim_create_user_command('Pager', function()
	vim.api.nvim_open_term(0, {})
end, { desc = 'Highlights ANSI termcodes in curbuf' })

vim.api.nvim_create_user_command('Update', function()
	vim.pack.update()
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
map('n', '?', 'ms?')

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

map('n', 'gh', function()
	vim.ui.open(
		vim.fn.expand('<cfile>'),
		{ cmd = { 'gh', 'repo', 'view', '--web' } }
	)
end)

map('n', '<leader>q', ":execute empty(filter(getwininfo(), 'v:val.quickfix')) ? 'copen' : 'cclose'<CR>",
	{ silent = true })

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

local function add_plugin(plugins, opts)
	opts = opts or {}
	local function do_add(plugs)
		vim.pack.add(plugs)
		for _, plug in ipairs(plugs) do
			if type(plug) == 'string' then
				plug = { src = plug }
			end
			local name = plug.name or plug.src
			name = vim.fs.basename(name)
			name = name:gsub('%.n?vim', '')
			name = name:gsub('%.', '-')
			pcall(require, 'plugins.' .. name)
		end
	end

	if opts.event ~= nil then
		vim.api.nvim_create_autocmd(opts.event, {
			once = true,
			group = augroup,
			desc = 'lazy-load plugins',
			callback = function()
				do_add(plugins)
			end
		})
	else
		do_add(plugins)
	end
end

local function gh(url) return 'https://github.com/' .. url end

add_plugin({
	gh 'blankname/vim-fish',
	gh 'nmac427/guess-indent.nvim',
	gh 'lukas-reineke/indent-blankline.nvim',
	gh 'luukvbaal/statuscol.nvim',
	gh 'yochem/chime.nvim',
	gh 'echasnovski/mini.ai',
	gh 'lewis6991/gitsigns.nvim',
	gh 'echasnovski/mini.splitjoin',
	gh 'yochem/jq-playground.nvim',
	gh 'tpope/vim-fugitive',
	gh 'folke/trouble.nvim',
	gh 'kaarmu/typst.vim',
	gh 'mcauley-penney/visual-whitespace.nvim',
	gh 'nvim-lua/plenary.nvim',
	gh 'nvim-telescope/telescope.nvim',
	{ src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
	{ src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
	gh 'yochem/prolog.vim',
	gh 'rafamadriz/friendly-snippets',
	{ src = gh 'saghen/blink.cmp', version = vim.version.range('1.*') },
})

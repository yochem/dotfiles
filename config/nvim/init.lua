if vim.g.vscode or vim.fn.has('nvim-0.10') == 0 then
	return
end
vim.loader.enable()

require('plugins')
vim.cmd.colorscheme('mine')
-- require('vim._extui').enable({})

vim.g.did_install_default_menus = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-------------
-- OPTIONS --
-------------
vim.cmd([[
let g:mapleader=' '
let g:netrw_banner=0
let g:netrw_liststyle=3

set laststatus=0
set noshowmode
set noruler
set shortmess=WIFsclo

set splitbelow
set splitright
set splitkeep=screen

set textwidth=79
set nowrap

set foldcolumn=1
set number
set numberwidth=1
set relativenumber
set signcolumn=yes:1
set cursorline

set list
set pumheight=10
set scrolloff=3
set sidescrolloff=1

set pumheight=10
set completeopt=menu,menuone,noselect

set title
set titlestring=%{&modified?'●\ ':''}%{empty(expand('%:t'))?'nvim':expand('%:t')}

set formatoptions=cqnj
set jumpoptions+=view,stack

set gdefault
set hlsearch
set ignorecase
set inccommand=split
set smartcase

set noexpandtab
set shiftround
set shiftwidth=4
set smartindent
set softtabstop=-1
set tabstop=4

set foldenable
set foldlevel=99
set foldlevelstart=99
set foldmethod=expr
set foldtext=

set spell
set spellsuggest=10
set spelloptions=camel,noplainbuffer

set autowrite
set nohidden
set undofile
set exrc
set secure

set shellcmdflag=-Nc
set timeoutlen=400
set updatetime=100

set path+=**
set wildmenu
set suffixes+=.pyc,.out,.pdf

set concealcursor=nc
set conceallevel=2

set statuscolumn=%C%@SignCb@%s%@NumCb@%=%l%#Comment#│
]])


vim.opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '',
	foldsep = ' ',
	foldclose = '',
	foldinner = ' ',
}
vim.opt.listchars = {
	tab = '  ',
	trail = '•',
	multispace = '••',
	leadmultispace = ' '
}

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

------------
-- REMAPS --
------------
local function cmd(command) return function() vim.cmd(command) end end
local map = vim.keymap.set
local nmap = function(lhs, rhs, opts) return map('n', lhs, rhs, opts) end
local vmap = function(lhs, rhs, opts) return map('v', lhs, rhs, opts) end

nmap('OO', '[<Space>', { remap = true })
nmap('oo', ']<Space>', { remap = true })

-- move highlighted text and auto indent
vmap('J', ":m '>+1<CR>gv=gv")
vmap('K', ":m '<-2<CR>gv=gv")

-- keep selection while visually indenting
vmap('<', '<gv')
vmap('>', '>gv')

-- resize windows
nmap('<S-Up>', cmd('resize +2'))
nmap('<S-Down>', cmd('resize -2'))
nmap('<S-Left>', cmd('vertical resize +2'))
nmap('<S-Right>', cmd('vertical resize -2'))

-- use comma to switch windows
nmap(',', '<c-w>')

-- Open file explorer left
nmap('<leader>e', cmd('15Lexplore'))

-- don't move so aggressive
nmap('<PageUp>', '10k')
nmap('<PageDown>', '10j')

-- populate jumplist with relative jumps, otherwise move by wrapped line
nmap('k', [[(v:count ? "m'" . v:count : "g") . "k"]], { expr = true })
nmap('j', [[(v:count ? "m'" . v:count : "g") . "j"]], { expr = true })

-- reselect pasted text like |gv| does for visually selected text
nmap('gp', '`[v`]')

nmap('<Esc>', function()
	vim.cmd.nohlsearch()
	vim.snippet.stop()
end)

-- always jump exactly to mark
nmap([[']], [[`]])

-- preserve cursor on joining lines
nmap('gJ', 'm`J``')

-- set mark before searching
nmap('/', 'ms/')
nmap('?', 'ms?')

-- only search in visual selection
map('x', '/', '<Esc>/\\%V')

-- don't care, just quit
nmap('ZZ', vim.cmd.qall)

-- close window
nmap('q', function()
	local success = pcall(vim.cmd.close)
	if not success then
		pcall(vim.cmd.quit)
	end
end)

nmap('gh', function()
	vim.ui.open(
		vim.fn.expand('<cfile>'),
		{ cmd = { 'gh', 'repo', 'view', '--web' } }
	)
end)

nmap('<leader>q', ":execute empty(filter(getwininfo(), 'v:val.quickfix')) ? 'copen' : 'cclose'<CR>",
	{ silent = true })

-- keep Q for macros
nmap('Q', 'q')

-- negate boolean values
nmap('!', '<Plug>(Negate)')

nmap('R', cmd('source %'))

-- ignore 'scrolloff' with H and L
nmap('H', function()
	vim._with({ o = { scrolloff = 0 } }, function()
		vim.cmd('norm! H')
	end)
end)

nmap('L', function()
	vim._with({ o = { scrolloff = 0 } }, function()
		vim.cmd('norm! L')
	end)
end)

-- sensible normal mode in terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>')

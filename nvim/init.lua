if vim.g.vscode or vim.fn.has('nvim-0.10') == 0 then
	return
end

vim.cmd.colorscheme('mine')
require('vim._core.ui2').enable({})

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
set titlestring=%{&modified?'●\ ':''}%{empty(expand('%'))?'nvim':expand('%:~:.')}

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
	tab = '│ ',
	trail = '•',
	multispace = '••',
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
end, { desc = 'split vertical if theres room' })

vim.api.nvim_create_user_command('Pager', function()
	vim.api.nvim_open_term(0, {})
end, { desc = 'Highlights ANSI termcodes in curbuf' })

vim.api.nvim_create_user_command('Make', function()
	-- TODO: smaller size
	vim.cmd([[hor terminal ]] .. vim.o.makeprg)
	vim.cmd.startinsert()
	vim.api.nvim_win_set_height(0, math.floor(vim.api.nvim_win_get_height(0) / 2))
end, {})

------------
-- REMAPS --
------------
local function cmd(command) return function() vim.cmd(command) end end
local map = vim.keymap.set

map('n', 'OO', '[<Space>', { remap = true })
map('n', 'oo', ']<Space>', { remap = true })

-- move highlighted text and auto indent
map('x', 'J', ":m '>+1<CR>gv=gv")
map('x', 'K', ":m '<-2<CR>gv=gv")

map('x', 'P', 'p')
map('x', 'p', 'P')

-- keep selection while visually indenting
map('x', '<', '<gv')
map('x', '>', '>gv')

-- use comma to switch windows
map('n', ',', '<c-w>')

-- don't move so aggressive
map('n', '<PageUp>', '10k')
map('n', '<PageDown>', '10j')

-- populate jumplist with relative jumps, otherwise move by wrapped line
map('n', 'k', [[(v:count ? "m'" . v:count : "g") . "k"]], { expr = true })
map('n', 'j', [[(v:count ? "m'" . v:count : "g") . "j"]], { expr = true })

-- reselect pasted text like |gv| does for visually selected text
map('n', 'gp', '`[v`]')

map('n', '<Esc>', function()
	vim.cmd.nohlsearch()
	vim.snippet.stop()
end)

-- always jump exactly to mark
map('n', [[']], [[`]])

-- preserve cursor on joining lines
map('n', 'gJ', 'J"_x')

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

map('n', '<leader>q', function ()
	for _, w in ipairs(vim.fn.getwininfo()) do
		if w.quickfix == 1 then
			vim.cmd.cclose()
			return
		end
	end
	vim.cmd.copen()
end)

-- keep Q for macros
map('n', 'Q', 'q')

-- negate boolean values
map('n', '!', '<Plug>(Negate)')

-- ignore 'scrolloff' with H and L
map('n', 'H', function()
	vim._with({ o = { scrolloff = 0 } }, function()
		vim.cmd('norm! H')
	end)
end)

map('n', 'L', function()
	vim._with({ o = { scrolloff = 0 } }, function()
		vim.cmd('norm! L')
	end)
end)

-- sensible normal mode in terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>')

-- map('n', '<leader>r', function()
-- 	vim.cmd.update()
-- 	vim.cmd.Make()
-- end)

map('n', '<leader>r', '<CMD>update | Make<CR>')

local old_open = vim.ui.open
vim.ui.open = function(path, opts)
	opts = opts or {}
	if path:match('#%d+') then
		opts.cmd = { 'gh', 'browse' }
	end
	return old_open(path, opts)
end

require('plugins')

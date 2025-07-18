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

vim.opt.path:append('**')
vim.o.wildmenu = true
vim.opt.suffixes = { '.swp', '.bak', '.pyc', '.out', '.aux', '.bbl', '.blg', '.pdf' }

vim.o.concealcursor = 'nc'
vim.o.conceallevel = 2

--------------
-- AUTOCMDS --
--------------
local augroup = vim.api.nvim_create_augroup('yochem', {})
function _G.on(event, callback)
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

on('WinNew', function(ev)
	if vim.fn.win_gettype(ev.id) ~= '' then
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

vim.api.nvim_create_user_command('Pager', function()
	vim.api.nvim_open_term(0, {})
end, { desc = 'Highlights ANSI termcodes in curbuf' })

vim.api.nvim_create_user_command('Update', function()
	vim.pack.update()
end, { desc = 'Highlights ANSI termcodes in curbuf' })


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

local gh = function(repo) return 'https://github.com/' .. repo end

local function add_plugin(plugins, opts)
	opts = opts or {}
	local function do_add()
		vim.pack.add(plugins)
		for _, plug in ipairs(plugins) do
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
			callback = do_add
		})
	else
		do_add()
	end
end

-- vim.pack.add({ 'https://github.com/yochem/lazy-vimpack' })
vim.opt.rtp:append(vim.fs.normalize('~/Documents/lazy-vimpack'))

require('lazy-vimpack').add({
	gh 'rafamadriz/friendly-snippets',
	{
		gh 'saghen/blink.cmp',
		version = vim.version.range('1.*'),
		main = 'blink.cmp',
		opts = {
			keymap = {
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'hide' },
				['<CR>'] = { 'accept', 'fallback' },
				['<S-Tab>'] = { 'select_prev', 'fallback' },
				['<Tab>'] = { 'select_next', 'fallback' },
				['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
				['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
				['<C-k>'] = {}
			},
			completion = {
				keyword = { range = 'full' },
				menu = {
					draw = {
						treesitter = { 'lsp' },
						padding = { 0, 1 },
						components = {
							kind_icon = {
								text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end
							}
						},
						columns = { { 'kind_icon', 'label', 'label_description' } },
					}
				},
				list = { selection = { preselect = false, auto_insert = true } },
				ghost_text = { enabled = true },
			},
			sources = {
				default = { 'omni', 'lsp', 'path', 'snippets', 'buffer' },
				providers = {
					buffer = {
						-- keep case of first char
						transform_items = function(a, items)
							local keyword = a.get_keyword()
							local correct, case
							if keyword:match('^%l') then
								correct = '^%u%l+$'
								case = string.lower
							elseif keyword:match('^%u') then
								correct = '^%l+$'
								case = string.upper
							else
								return items
							end

							-- avoid duplicates from the corrections
							local seen = {}
							local out = {}
							for _, item in ipairs(items) do
								local raw = item.insertText
								if raw:match(correct) then
									local text = case(raw:sub(1, 1)) .. raw:sub(2)
									item.insertText = text
									item.label = text
								end
								if not seen[item.insertText] then
									seen[item.insertText] = true
									table.insert(out, item)
								end
							end
							return out
						end
					}
				},
			},
			signature = { enabled = true },
		},
	},
	gh 'yochem/chime.nvim',
	gh 'blankname/vim-fish',
	gh 'tpope/vim-fugitive',
	{
		gh 'lewis6991/gitsigns.nvim',
		main = 'gitsigns',
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "│" },
				untracked = { text = "│" },
			},
		}
	},
	{
		gh 'lukas-reineke/indent-blankline.nvim',
		config = function()
			local hooks = require('ibl.hooks')
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require('ibl').setup({
				scope = { enabled = false },
				exclude = { filetypes = { 'help', 'man', 'packer' } },
				indent = { tab_char = '│' },
			})
		end,
	},
	gh 'yochem/jq-playground.nvim',
	{
		gh 'echasnovski/mini.splitjoin',
		main = 'mini.splitjoin',
		opts = { mappings = { toggle = '<leader>a' } }
	},
	gh 'yochem/prolog.vim',
	{
		gh 'luukvbaal/statuscol.nvim',
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				ft_ignore = { "qf" },
				segments = {
					{
						sign = {
							namespace = { "jumpsigns", "diagnostic.signs" },
							maxwidth = 1,
							colwidth = 1,
						},
						click = "v:lua.ScSa",
					},
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{ text = { builtin.lnumfunc },      click = "v:lua.ScLa" },
					{
						sign = {
							namespace = { "gitsign" },
							maxwidth = 1,
							colwidth = 1,
							fillchar = "│",
							fillcharhl = "@comment",
						},
						click = "v:lua.ScSa",
					},
				},
			})
		end,
	},
	gh 'nvim-lua/plenary.nvim',
	{
		gh 'nvim-telescope/telescope.nvim',
		config = function()
			local function ts_func(func, args)
				return function() require("telescope.builtin")[func](args) end
			end
			map("n", "<leader>ff", ts_func("find_files"))
			map("n", "<leader>fg", ts_func("live_grep"))
			map("n", "<leader>fb", ts_func("buffers"))
			map("n", "<leader>fF", ts_func("lsp_document_symbols"))
			map("n", "<leader>fh", ts_func("help_tags"))
			map("n", "<leader>fq", ts_func("quickfix"))
			map("n", "<leader>fd", ts_func("find_files", { cwd = vim.fn.stdpath("config") }))

			require('telescope').setup({
				pickers = {
					find_files = {
						theme = "ivy",
						preview = false,
						hidden = true,
					},
					live_grep = {
						theme = "ivy",
					},
					buffers = {
						theme = "dropdown",
						initial_mode = "normal",
					},
					lsp_document_symbols = {
						symbols = {
							"class",
							"function",
							"struct",
						},
					},
				},
			})
		end
	},
	{
		gh 'folke/trouble.nvim',
		config = function()
			require('trouble').setup({
				focus = false,
				warn_no_results = false,
				modes = {
					symbols = {
						format = "{kind_icon} {symbol.name}",
						multiline = false,
					}
				},
			})
			map('n', 'gO', '<Cmd>Trouble symbols<CR>')
		end
	},
	{ src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
	gh 'kaarmu/typst.vim',
	{ gh 'mcauley-penney/visual-whitespace.nvim', opts = {}, main = 'visual-whitespace' },
	{ gh 'nmac427/guess-indent.nvim', main = 'guess-indent', opts = {} },
	{ gh 'echasnovski/mini.ai', main = 'mini.ai', opts = {}, event = { 'BufReadPost', 'BufNewFile' } },
	{
		gh 'nvim-treesitter/nvim-treesitter-textobjects',
		version = 'main',
		event = { 'BufReadPost', 'BufNewFile' },
		config = function()
			local keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["as"] = "@statement.outer",
				["ic"] = "@comment.inner",
				["ac"] = "@comment.outer",
			}
			local ts = require("nvim-treesitter-textobjects.select")
			for rhs, object in pairs(keymaps) do
				vim.keymap.set({ 'x', 'o' }, rhs, function()
					ts.select_textobject(object, "textobjects")
				end)
			end
		end
	},
})

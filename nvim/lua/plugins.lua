local configs = {
	autolang = { limit_languages = { "nl", "en" } },
	['blink.cmp'] = {
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
							text = function(ctx)
								return (' %s%s '):format(ctx.kind_icon, ctx.icon_gap)
							end
						}
					},
					columns = { { 'kind_icon', 'label', 'label_description' } },
				}
			},
			list = { selection = { preselect = false, auto_insert = true } },
			ghost_text = { enabled = true },
		},
		sources = { default = { 'omni', 'lsp', 'path', 'snippets', 'buffer' } },
		signature = { enabled = true },
	},
	artio = {
		opts = { use_icons = false },
		mappings = {
			["<C-n>"] = "down",
			["<C-p>"] = "up",
			["<CR>"] = "accept",
			["<ESC>"] = "cancel",
			["<TAB>"] = "mark",
			["<C-l>"] = "togglepreview",
			["<C-q>"] = "setqflistmark",
		},
	},
	['guess-indent'] = {},
	['mini.splitjoin'] = { mappings = { toggle = '<leader>a' } },
	['typst-preview'] = {},
	gitsigns = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "│" },
			untracked = { text = "│" },
		},
	},
	quicker = {},
}

vim.api.nvim_create_user_command('Update', function(args)
	vim.pack.update(nil, { force = args.bang })
end, { bang = true })

vim.api.nvim_create_autocmd('PackChanged', {
	group = vim.api.nvim_create_augroup('me.plugin.install', {}),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if kind ~= 'install' and kind ~= 'update' then
			return
		end
		if (ev.data.spec.data or {}).build then
			vim.cmd.packadd(name)
			vim.cmd(ev.data.spec.data.build)
		end
	end,
})

local function add(plugins)
	vim.pack.add(plugins, { confirm = false })
	for _, plug in ipairs(plugins) do
		if type(plug) == 'string' then
			plug = { src = plug }
		end

		local name = plug.name or vim.fs.basename(plug.src)
		-- strip '(n)vim-', '-(n)vim', and '.(n)vim'
		name = name:gsub('[%-.]?n?vim[%-.]?', '')

		local config = configs[name]
		if type(config) == 'table' then
			require(name).setup(config)
		elseif vim.is_callable(config) then
			config()
		end
	end
end

-- TODO: let's make this lazy
local function gh(url) return 'https://github.com/' .. url end
local semver = vim.version.range

add({
	{ src = gh 'nvim-treesitter/nvim-treesitter',             version = 'main',     data = { build = 'TSUpdate' } },
	{ src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
	{ src = gh 'saghen/blink.cmp',                            version = semver('*') },
	-- { src = gh 'yochem/autolang.nvim', version = 'tmp' }
})

vim.schedule(function()
	add({
		gh "comfysage/artio.nvim",
		gh 'nmac427/guess-indent.nvim', -- does this even work?
		gh 'rafamadriz/friendly-snippets',
		gh 'yochem/chime.nvim',
		gh 'nvim-mini/mini.splitjoin',
		gh 'yochem/jq-playground.nvim',
		gh 'tpope/vim-fugitive',
		gh 'mcauley-penney/visual-whitespace.nvim',
		{ src = gh 'chomosuke/typst-preview.nvim', version = semver('1.*') },
		gh 'lewis6991/gitsigns.nvim',
		gh 'stevearc/quicker.nvim',
	})
end)

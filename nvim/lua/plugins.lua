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
		name = name:gsub('[%-.]?n?vim[%-.]?', '')

		if type(plug.config) == 'table' then
			require(name).setup(plug.config)
		elseif vim.is_callable(plug.config) then
			plug.config()
		end
	end
end

---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param opts vim.api.keyset.create_autocmd
---@param plugs vim.pack.Spec[]
local function load_on(event, opts, plugs)
	local sha = vim.fn.sha256(vim.inspect(plugs)):sub(1, 5)
	local group = vim.api.nvim_create_augroup('plugins-' .. sha, {})
	opts.group = group
	opts.once = true
	opts.callback = vim.schedule_wrap(function()
		add(plugs)
		vim.api.nvim_del_augroup_by_id(group)
	end)
	vim.api.nvim_create_autocmd(event, opts)
end

-- TODO: let's make this lazy
local function gh(url) return 'https://github.com/' .. url end
add({
	{
		src = gh 'luukvbaal/statuscol.nvim',
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				ft_ignore = { "qf", "terminal" },
				segments = {
					{
						sign = {
							namespace = { "jumpsigns", "diagnostic.signs", ".*" },
							maxwidth = 1,
							colwidth = 1,
						},
						click = "v:lua.ScSa",
					},
					{ text = { "%C", " " },        click = "v:lua.ScFa" },
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
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
		end
	},
	{
		src = gh 'nvim-treesitter/nvim-treesitter',
		version = 'main',
		data = { build = 'TSUpdate' },
	},
	{
		src = gh 'nvim-treesitter/nvim-treesitter-textobjects',
		version = 'main',
	},
	{
		src = gh 'saghen/blink.cmp',
		version = vim.version.range('*'),
		config = {
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
			sources = { default = { 'omni', 'lsp', 'path', 'snippets', 'buffer' } },
			signature = { enabled = true },

		}
	}
	-- {
	-- 	src = gh 'suderio/autolang.nvim',
	-- 	config = {
	-- 		limit_languages = { "nl", "en" },
	-- 	}
	-- }
})

load_on('BufReadPost', {}, {
	{
		src = gh 'lewis6991/gitsigns.nvim',
		config = {
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
})


load_on({ 'BufReadPre', 'BufNew', 'LspAttach' }, {}, {
	{
		src = gh "comfysage/artio.nvim",
		config = {
			opts = {
				use_icons = false,
			},
			mappings = {
				["<C-n>"] = "down",
				["<C-p>"] = "up",
				["<CR>"] = "accept",
				["<ESC>"] = "cancel",
				["<TAB>"] = "mark",
				["<C-l>"] = "togglepreview",
				["<C-q>"] = "setqflistmark",
			},
		}
	},
	{ src = gh 'nmac427/guess-indent.nvim', config = {} }, -- does this even work?
	gh 'rafamadriz/friendly-snippets',
	gh 'yochem/chime.nvim',
	{
		src = gh 'nvim-mini/mini.splitjoin',
		config = { mappings = { toggle = '<leader>a' } }
	},
	gh 'yochem/jq-playground.nvim',
	gh 'tpope/vim-fugitive',
})

load_on('FileType', { pattern = 'typst' }, { {
	src = gh 'chomosuke/typst-preview.nvim',
	version = vim.version.range('1.*'),
	config = {},
} })

load_on({ 'ModeChanged' }, {}, {
	gh 'mcauley-penney/visual-whitespace.nvim',
})

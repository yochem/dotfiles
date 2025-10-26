local augroup = vim.api.nvim_create_augroup('yochem.packages', {})

vim.api.nvim_create_user_command('Update', function(args)
	vim.pack.update(nil, { force = args.bang })
end, { bang = true })

local function packadd(plugin)
	-- local support. Can be dropped later
	local p = vim.fs.normalize(vim.fs.joinpath('~/Documents', vim.fs.basename(plugin.path)))
	if string.find(plugin.spec.src, 'yochem') and vim.uv.fs_stat(p) then
		vim.opt.rtp:append(p)
	else
		local load = vim.v.vim_did_enter == 1
		vim.cmd.packadd({ vim.fn.escape(plugin.spec.name, ' '), bang = not load, magic = { file = false } })
	end
	local name = plugin.spec.name
	name = vim.fs.basename(name)
	name = name:gsub('%.', '-')
	name = name:gsub('%-?n?vim%-?', '')
	pcall(require, 'plugins.' .. name)
end

local function lazy(plugin, event, pattern)
	vim.api.nvim_create_autocmd(event, {
		once = true,
		pattern = pattern or '*',
		group = augroup,
		desc = 'lazy-load plugins',
		callback = function()
			packadd(plugin)
		end
	})
end

local function gh(url) return 'https://github.com/' .. url end

local function loadfunc(plugin)
	local data = plugin.spec.data or {}

	if data.deps then
		vim.pack.add(data.deps, { load = loadfunc, confirm = false })
	end

	if data.event then
		lazy(plugin, data.event)
	elseif data.ft then
		lazy(plugin, 'FileType', data.ft)
	else
		packadd(plugin)
	end
end

local old_vimpackadd = vim.pack.add
vim.pack.add = function(plugins, opts)
	opts = vim.tbl_extend('force', { load = loadfunc, confirm = false }, opts or {})

	vim.api.nvim_create_autocmd('PackChanged', {
		group = augroup,
		callback = function(ev)
			if ev.data.kind ~= 'delete' then
				if (ev.data.spec.data or {}).build then
					vim.cmd.packadd(ev.data.spec.name)
					vim.cmd(ev.data.spec.data.build)
				end
			end
		end
	})

	old_vimpackadd(plugins, opts)
end

vim.pack.add({
	gh 'nmac427/guess-indent.nvim',
	gh 'lukas-reineke/indent-blankline.nvim',
	-- gh 'luukvbaal/statuscol.nvim',
	gh 'yochem/chime.nvim',
	gh 'nvim-mini/mini.ai',
	gh 'lewis6991/gitsigns.nvim',
	gh 'nvim-mini/mini.splitjoin',
	gh 'yochem/jq-playground.nvim',
	gh 'tpope/vim-fugitive',
	gh 'folke/trouble.nvim',
	{
		src = gh 'mcauley-penney/visual-whitespace.nvim',
		data = { event = 'ModeChanged' },
	},
	{
		src = gh 'nvim-telescope/telescope.nvim',
		data = { deps = { gh 'nvim-lua/plenary.nvim' } },
	},
	{
		src = gh 'nvim-treesitter/nvim-treesitter-textobjects',
		version = 'main',
		data = {
			deps = {
				{
					src = gh 'nvim-treesitter/nvim-treesitter',
					version = 'main',
					data = { build = 'TSUpdate' },
				},
			},
		},
	},
	{
		src = gh 'saghen/blink.cmp',
		version = vim.version.range('*'),
		data = { deps = { gh 'rafamadriz/friendly-snippets' } }
	},
	{
		src = gh 'chomosuke/typst-preview.nvim',
		version = vim.version.range('1.*'),
		data = { ft = 'typst' },
	},
})

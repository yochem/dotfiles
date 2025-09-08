vim.api.nvim_create_user_command('Update', function(args)
	vim.pack.update(nil, { force = args.bang })
end, { bang = true })

local function do_add(plugin)
	if type(plugin) == 'string' then
		plugin = { src = plugin }
	end

	local p = vim.fs.normalize(vim.fs.joinpath('~/Documents', vim.fs.basename(plugin.src)))
	if string.find(plugin.src, 'yochem') and vim.uv.fs_stat(p) then
		vim.opt.rtp:append(p)
	else
		vim.pack.add({ plugin })
	end
	local name = plugin.name or plugin.src
	name = vim.fs.basename(name)
	name = name:gsub('%.', '-')
	name = name:gsub('%-?n?vim%-?', '')
	pcall(require, 'plugins.' .. name)
end

local function gh(url) return 'https://github.com/' .. url end

local function register_plugins(plugs)
	local pack_augroup = vim.api.nvim_create_augroup('yochem.packages', {})
	for _, plugin in ipairs(plugs) do
		if type(plugin) == 'string' then
			plugin = { src = plugin }
		end

		if plugin.deps then
			register_plugins(plugin.deps)
		end

		if plugin.event ~= nil then
			vim.api.nvim_create_autocmd(plugin.event, {
				once = true,
				group = pack_augroup,
				desc = 'lazy-load plugins',
				callback = function()
					do_add(plugin)
				end
			})
		else
			do_add(plugin)
		end

		if plugin.build then
			vim.api.nvim_create_autocmd('PackChanged', {
				once = true,
				group = pack_augroup,
				callback = function()
					vim.cmd(plugin.build)
				end
			})
		end
	end
end


register_plugins({
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
	gh 'mcauley-penney/visual-whitespace.nvim',
	{ src = gh 'nvim-telescope/telescope.nvim', deps = { gh 'nvim-lua/plenary.nvim' } },
	{ src = gh 'nvim-treesitter/nvim-treesitter',             version = 'main', build = 'TSUpdate' },
	{ src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
	{
		src = gh 'saghen/blink.cmp',
		version = vim.version.range('*'),
		deps = {
			gh 'rafamadriz/friendly-snippets',
		}
	},
	{ src = gh 'chomosuke/typst-preview.nvim', version = vim.version.range('1.*') },
})

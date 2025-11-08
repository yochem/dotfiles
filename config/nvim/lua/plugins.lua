vim.api.nvim_create_user_command('Update', function(args)
	vim.pack.update(nil, { force = args.bang })
end, { bang = true })

local function add(plugins, load)
	vim.api.nvim_create_autocmd('PackChanged', {
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if kind ~= 'install' and kind ~= 'update' then
				return
			end
			if ev.data.spec.data.build then
				vim.cmd.packadd(name)
				vim.cmd(ev.data.spec.data.build)
			end
		end,
	})
	vim.pack.add(plugins, { confirm = false, load = load })
	for _, plug in ipairs(plugins) do
		if type(plug) == 'string' then
			plug = { src = plug }
		end

		local name = plug.name or plug.src
		name = vim.fs.basename(name)
		name = name:gsub('%.', '-')
		name = name:gsub('%-?n?vim%-?', '')
		local ok, msg = pcall(require, 'plugins.' .. name)
		if not ok and not msg:match('not found') then
			vim.notify(msg, vim.log.levels.ERROR)
		end
	end
end

local function gh(url) return 'https://github.com/' .. url end
add({
	gh 'nmac427/guess-indent.nvim',
	gh 'luukvbaal/statuscol.nvim',
	gh 'yochem/chime.nvim',
	-- gh 'nvim-mini/mini.ai',
	gh 'lewis6991/gitsigns.nvim',
	gh 'nvim-mini/mini.splitjoin',
	gh 'yochem/jq-playground.nvim',
	gh 'tpope/vim-fugitive',
	gh 'folke/trouble.nvim',
	gh 'nvim-lua/plenary.nvim',
	gh 'nvim-telescope/telescope.nvim',
	{ src = gh 'nvim-treesitter/nvim-treesitter',             version = 'main', data = { build = 'TSUpdate' } },
	{ src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
	gh 'rafamadriz/friendly-snippets',
	{ src = gh 'saghen/blink.cmp',             version = vim.version.range('*') },
	gh 'mcauley-penney/visual-whitespace.nvim',
	{ src = gh 'chomosuke/typst-preview.nvim', version = vim.version.range('1.*') },
})

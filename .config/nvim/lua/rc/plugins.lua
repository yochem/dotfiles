require('paq')({
	'savq/paq-nvim',

	-- improving vim experience
	'b3nj5m1n/kommentary',
	'kevinhwang91/nvim-hlslens',
	'FooSoft/vim-argwrap',
	'wellle/targets.vim',
	'gbprod/substitute.nvim',
	'nmac427/guess-indent.nvim',

	-- improve vim looks
	'ful1e5/onedark.nvim',
	'lukas-reineke/indent-blankline.nvim',
	'lukas-reineke/virt-column.nvim',
	'nvim-lualine/lualine.nvim',

	-- IDE functionality
	'gpanders/editorconfig.nvim',
	'tpope/vim-fugitive',
	'neovim/nvim-lspconfig',
	-- 	'hrsh7th/nvim-cmp',
	-- 	'hrsh7th/cmp-nvim-lsp',
	-- 	'saadparwaiz1/cmp_luasnip',
	-- 'L3MON4D3/LuaSnip',
	'ms-jpq/coq_nvim',
	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/nvim-treesitter-textobjects',
	'lewis6991/spellsitter.nvim',
	'nvim-treesitter/playground',
	'SmiteshP/nvim-gps',
	   'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	'kosayoda/nvim-lightbulb',
	'lewis6991/gitsigns.nvim',

	-- better filetypes
	'yochem/prolog.vim',
	'blankname/vim-fish',
	'vim-python/python-syntax',
	'Vimjas/vim-python-pep8-indent',
	'chrisbra/csv.vim',
})

-- paq does not support local packages
vim.opt.runtimepath:append('~/Documents/jvim.nvim')
vim.opt.runtimepath:append('~/Documents/autosplit.nvim')

require('autosplit').setup({split = 'auto'})
vim.cmd('cabbrev sp Split')
vim.cmd('cabbrev vs Split')

require('kommentary.config').configure_language('default', {
	prefer_single_line_comments = true,
	use_consistent_indentation = true,
})

require('hlslens').setup({calm_down = true})

require('onedark').setup({
	transparent = true,
	transparent_sidebar = false,
	comment_style = 'NONE',
	keyword_style = 'NONE',
	function_style = 'NONE',
	variable_style = 'NONE',
	colors = {
		fg0 = '#ffffff',
	},
	overrides = function(c)
		local Styles = require('onedark.types').od.HighlightStyle
		return {
			MsgArea = {fg = c.fg0},
			LineNr = {fg = c.fg_light},
			ColorColumn = {bg = c.none},
			TSField = {fg = c.fg0},
			TSOperator = {fg = c.fg0},
			TSParameter = {fg = c.orange0},
			pythonTSFuncBuiltin = {fg = c.blue0},
			TSVariable = {fg = c.fg0},
			TSPunctBracket = {c.fg0},
			TSConstructor = {fg = c.fg0},
			TSEmphasis = {style = Styles.Bold},
		}
	end
})

require('indent_blankline').setup({
	filetype_exclude = {'help', 'man', 'packer'},
	show_first_indent_level = false,
	show_trailing_blankline_indent = false
})

require('virt-column').setup()

vim.g.coq_settings = {
	auto_start = 'shut-up',
	xdg = true,
	['keymap.jump_to_mark'] = '<tab>',
	display = {
		pum = {
			y_max_len = 10,
			kind_context = {'', ''},
			source_context = {'', ''},
		},
		icons = {mode = 'none'},
		['icons.mode'] = 'none'
	},
	clients = {
		buffers = {enabled = true, weight_adjust = -1.9},
		tree_sitter = {enabled = true, weight_adjust = -1.5},
		lsp = {enabled = true, weight_adjust = 1.5},
		snippets = {enabled = true, weight_adjust = 3, warn = {}},
		tmux = {enabled = false},
	}
}


require('nvim-gps').setup({disable_icons = true, separator = '.'})

require('guess-indent').setup({tabstop = 4})

require('substitute').setup()

require('nvim-lightbulb').setup({
	sign = {enabled = false},
	status_text = {enabled = true},
	autocmd = {enabled = true},
})

local gps = require('nvim-gps')

local function lsp()
	if #vim.lsp.buf_get_clients() > 0 then
		return 'LSP'
	end
	return ''
end

local function wordcount()
	local ft = vim.bo.filetype
	if ft == 'markdown' or ft == 'text' then
		if vim.fn.wordcount().visual_words then
			return vim.fn.wordcount().visual_words .. ' words'
		else
			return vim.fn.wordcount().words .. ' words'
		end
	end
	return ''
end

local function filename()
	local ft = vim.bo.filetype
	if ft == 'help' or ft == 'man' then
		return vim.fn.expand('%')
	else
		local fn = vim.fn.expand('%:p')
		fn = fn:gsub('/Users/yochem', '~')

		if fn == '' then
			return '[No Name]'
		end

		if #fn > 30 then
			fn = fn:gsub('/(%.?%w%)%w+/', '/%1/', 1)
		end

		return fn
	end
end

require('lualine').setup({
	options = {
		icons_enabled = false,
		component_separators = { left = '|', right = '|'},
		section_separators = { left = '', right = ''},
		globalstatus = true,
		theme = 'auto',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		lualine_c = {
			filename,
			{gps.get_location, cond = gps.is_available}
		},
		lualine_x = {wordcount, 'filetype'},
		lualine_y = {
			lsp,
			'require("nvim-lightbulb").get_status_text()',
			'diagnostics'
		},
		lualine_z = {'location'}
	},
})

require('nvim-treesitter.configs').setup({
	highlight = {enable = true},
	indent = {enable = true},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
	},
})

require('gitsigns').setup()

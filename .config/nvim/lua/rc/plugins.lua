require('paq')({
	'savq/paq-nvim',
	'lewis6991/impatient.nvim',

	-- improving vim experience
	'b3nj5m1n/kommentary',
	'kevinhwang91/nvim-hlslens',
	'FooSoft/vim-argwrap',
	'wellle/targets.vim',
	'gbprod/substitute.nvim',
	'nmac427/guess-indent.nvim',

	-- improve vim looks
	'navarasu/onedark.nvim',
	-- 'Mofiqul/vscode.nvim',
	-- 'kdheepak/monochrome.nvim',
	'lukas-reineke/indent-blankline.nvim',
	'lukas-reineke/virt-column.nvim',
	'nvim-lualine/lualine.nvim',

	-- IDE functionality
	'gpanders/editorconfig.nvim',
	'tpope/vim-fugitive',
	'neovim/nvim-lspconfig',
	'ms-jpq/coq_nvim',
	'ms-jpq/coq.artifacts',
	'ray-x/lsp_signature.nvim',
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
	'chrisbra/csv.vim',
	'ollykel/v-vim',

	'dstein64/vim-startuptime'
})

require('impatient')

require('onedark').setup({
	style = 'darker',
	transparent = true,
	colors = {
		fg = '#fff'
	},
	highlights = {
		MsgArea = {fg = '$fg'},
		LineNrAbove = {fg = '#adbac7'},
		LineNrBelow = {fg = '#adbac7'},
		LineNr = {fg = '$fg'},
		StatusLine = {fg = '$fg'},
		Comment = {fg = '$light_grey'},
	}
})
require('onedark').load()

vim.opt.runtimepath:append('~/Documents/jvim.nvim')
--[[ vim.opt.runtimepath:append('~/Documents/autosplit.nvim')

require('autosplit').setup({split = 'auto'})
vim.cmd('cabbrev sp Split')
vim.cmd('cabbrev vs Split') ]]

require('kommentary.config').configure_language('default', {
	prefer_single_line_comments = true,
	use_consistient_indentation = true,
})

require('hlslens').setup({calm_down = true})

require('virt-column').setup()

vim.g.coq_settings = {
	auto_start = 'shut-up',
	xdg = true,
	keymap = {
		jump_to_mark = '<c-h>',
		pre_select = false,
	},
	display = {
		ghost_text = {enabled = false},
		pum = {
			y_max_len = 10,
			kind_context = {'', ''},
			source_context = {'', ''},
		},
		icons = {mode = 'none'},
	},
	clients = {
		buffers = {enabled = true, weight_adjust = -1.9},
		tree_sitter = {enabled = true, weight_adjust = 1},
		lsp = {enabled = true, weight_adjust = 1.5},
		snippets = {enabled = true, weight_adjust = 1.2, warn = {}},
		tmux = {enabled = false},
	},
	match = {
		unifying_chars = {'-'}
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
	local clients = vim.lsp.get_active_clients()
	if #clients > 0 then
		return 'LSP:' .. clients[1].name
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

local custom_onedark = require('lualine.themes.onedark')
custom_onedark.normal.b.fg = '#fff'
custom_onedark.normal.c.fg = '#fff'

require('lualine').setup({
	options = {
		icons_enabled = false,
		component_separators = '|',
		section_separators = '',
		globalstatus = true,
		theme = custom_onedark,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		lualine_c = {
			{'filename', path = 3 },
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
	highlight = {enable = false},
	indent = {enable = false},
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

require('indent_blankline').setup({
	filetype_exclude = {'help', 'man', 'packer'},
	show_first_indent_level = false,
	show_trailing_blankline_indent = false
})

require('gitsigns').setup()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'lewis6991/impatient.nvim'

	-- improving vim experience
	use {
		'numToStr/Comment.nvim',
		config = function () require('Comment').setup() end
	}

	use {
		'kevinhwang91/nvim-hlslens',
		config = function() require('hlslens').setup({calm_down = true}) end
	}

	use 'FooSoft/vim-argwrap'

	use 'wellle/targets.vim'

	use {
		'nmac427/guess-indent.nvim',
		config = function() require('guess-indent').setup({tabstop = 4}) end,
	}

	use {
		'folke/trouble.nvim',
		config = function()
			require('trouble').setup({
				icons = false,
				use_diagnostic_signs = true,
				fold_open = '',
				fold_closed = '',
				auto_close = true,
				height = 7,
				padding = false,
				auto_preview = false,
			})
		end
	}

	-- improve vim looks
	use {
		'navarasu/onedark.nvim',
		config = function ()
			require('onedark').setup({
				style = 'darker',
				transparent = true,
				colors = {
					fg = '#fff'
				},
				highlights = {
					ColorColumn = {bg = '$none'},
					MsgArea = {fg = '$fg'},
					LineNrAbove = {fg = '#adbac7'},
					LineNrBelow = {fg = '#adbac7'},
					LineNr = {fg = '$fg'},
					StatusLine = {fg = '$fg'},
					Comment = {fg = '$light_grey'},
					['@comment'] = {fg = '$light_grey'},
					['@field'] = {fg = '$fg'}
				}
			})
			require('onedark').load()
		end
	}

	use {
		'lukas-reineke/indent-blankline.nvim',
		config = function()
				require('indent_blankline').setup({
				filetype_exclude = {'help', 'man', 'packer'},
				show_first_indent_level = false,
				show_trailing_blankline_indent = false
			})
		end,
		requires = 'nvim-treesitter/nvim-treesitter',
	}

	use {
		'lukas-reineke/virt-column.nvim',
		config = function() require('virt-column').setup({char = '│'}) end,
	}

	use {
		'nvim-lualine/lualine.nvim',
		config = function ()
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
		end
	}

	use 'neovim/nvim-lspconfig'

	use {
		'seblj/nvim-echo-diagnostics',
		config = function ()
			require('echo-diagnostics').setup({
				show_diagnostic_number = false,
				show_diagnostic_source = true,
			})
			vim.api.nvim_create_autocmd('CursorHold', {
				callback = require('echo-diagnostics').echo_line_diagnostic
			})
		end
	}

	use {'L3MON4D3/LuaSnip'}

	use {
		'hrsh7th/nvim-cmp',
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local luasnip = require("luasnip")
			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' }, -- For luasnip users.
					{ name = 'path' },
				}, {
					{ name = 'buffer' },
				})
			})
		end,
		requires = {
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'onsails/lspkind-nvim',
			'nvim-lua/lsp_extensions.nvim',
			'glepnir/lspsaga.nvim',
			'simrat39/symbols-outline.nvim',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets'
		}
	}

	use {
		'narutoxy/dim.lua',
		requires = {'nvim-treesitter/nvim-treesitter', 'neovim/nvim-lspconfig'},
		config = function()
			require('dim').setup({})
		end
	}

	-- IDE functionality
	use 'tpope/vim-fugitive'
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function ()
			require('nvim-treesitter.configs').setup({
				highlight = {
					enable = true
				}
			})
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		config = function()
			require('nvim-treesitter.configs').setup({
				highlight = {enable = true},
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
							["ac"] = "@comment.outer",
							["as"] = "@statement.outer",
						},
					},
					move = {
						enable = true,
						goto_next_start = {
							["]f"] = "@function.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
						},
					}
				},
			})
		end,
	}

	use 'lewis6991/spellsitter.nvim'

	use 'nvim-treesitter/playground'

	use {
		'SmiteshP/nvim-gps',
		config = function()
			require('nvim-gps').setup({disable_icons = true, separator = '.'})
		end,
		requires = 'nvim-lua/plenary.nvim',
	}

	use 'nvim-telescope/telescope.nvim'

	use {
		'kosayoda/nvim-lightbulb',
		config = function()
			require('nvim-lightbulb').setup({
				sign = {enabled = false},
				status_text = {enabled = true},
				autocmd = {enabled = true},
			})
		end
	}

	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}

	-- better filetypes
	use {'yochem/prolog.vim', ft = 'prolog'}
	use {'blankname/vim-fish', ft = 'fish'}
	use {'vim-python/python-syntax', ft = 'python'}
	use {'chrisbra/csv.vim', ft = 'csv'}
	use {'ollykel/v-vim', ft = 'vlang'}

	use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

		use {
			'~/Documents/autosplit.nvim',
			config = function ()
				require('autosplit').setup({split = 'auto'})
				vim.cmd.cabbrev({'sp', 'Split'})
				vim.cmd.cabbrev({'vs', 'Split'})
			end
		}

end)

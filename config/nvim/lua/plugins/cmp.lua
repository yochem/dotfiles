local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

return {
	"hrsh7th/nvim-cmp",
	commit = "b356f2c",
	pin = true,
	event = "InsertEnter",
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<TAB>"] = cmp.mapping.select_next_item(),
				["<S-TAB>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			},
			sources = {
				{ name = "nvim_lsp_signature_help" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{
					name = "buffer",
					option = {
						keyword_length = 6,
					}
				},
				{ name = "htmx" },
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = kind_icons[vim_item.kind]
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp_signature_help = "[LSP]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						path = "[Path]",
						htmx = "[HTMX]",
						spell = "[Spell]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})
	end,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		{
			dir = "~/Documents/cmp-htmx",
			dev = true,
			name = "cmp-htmx",
		},
	},
}

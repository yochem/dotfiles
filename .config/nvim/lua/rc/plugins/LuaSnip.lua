local map = require('rc.remaps').map

return {
	"L3MON4D3/LuaSnip",
	event = 'InsertEnter',
	init = function ()
		map(
		'i',
		'<Tab>',
		"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
		{expr = true}
		)
		map('i', '<S-Tab>', function() require("luasnip").jump(-1) end)
	end,
	dependencies = {"rafamadriz/friendly-snippets"}
}

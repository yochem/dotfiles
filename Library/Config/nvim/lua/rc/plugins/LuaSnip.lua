return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	init = function()
		vim.keymap.set("i", "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { expr = true })
		vim.keymap.set("i", "<S-Tab>", function()
			require("luasnip").jump(-1)
		end)
	end,
	dependencies = { "rafamadriz/friendly-snippets" },
}

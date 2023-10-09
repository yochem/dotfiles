return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	init = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
	dependencies = { "rafamadriz/friendly-snippets" },
}

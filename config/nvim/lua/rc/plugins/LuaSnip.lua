return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	init = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
	end,
	dependencies = { "rafamadriz/friendly-snippets" },
}

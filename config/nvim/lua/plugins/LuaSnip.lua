return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	lazy = true,
	init = function()
		local luasnip = require("luasnip")
		vim.keymap.set({ "i", "s" }, "<C-n>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end)
		vim.keymap.set({ "i", "s" }, "<C-p>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end)
	end,
	dependencies = { "rafamadriz/friendly-snippets" },
}

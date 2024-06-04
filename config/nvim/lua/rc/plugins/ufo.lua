return {
	"kevinhwang91/nvim-ufo",
	init = function()
		vim.keymap.set("n", "zR", function()
			require("ufo").openAllFolds()
		end)
		vim.keymap.set("n", "zR", function()
			require("ufo").closeAllFolds()
		end)
	end,
	opts = {
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
	},
	dependencies = {
		"kevinhwang91/promise-async",
	},
	event = "VeryLazy",
}

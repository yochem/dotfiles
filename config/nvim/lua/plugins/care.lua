return {
	"max397574/care.nvim",
	dependencies = {
		{
			{ "romgrk/fzy-lua-native", name = "fzy" },
			"max397574/care-cmp",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			-- { "petertriho/cmp-git", opts = {}},
		}
	},
	opts = {
		ui = {
			menu = { border = "none" },
			docs_view = { border = "none" },
			ghost_text = { position = "inline" },
		},
		snippet_expansion = function(body)
			require("luasnip").lsp_expand(body)
		end,
		preselect = false,
	},
	init = function()
		vim.keymap.set("i", "<C-space>", function() require("care").api.complete() end, { desc = "open completion menu" })
		vim.keymap.set("i", "<CR>", function()
			if require("care").api.get_index() ~= 0 then
				require("care").api.confirm()
			else
				vim.api.nvim_feedkeys(vim.keycode("<CR>"), "n", false)
			end
		end)
		vim.keymap.set("i", "<C-e>", "<Plug>(CareClose)", { desc = "Care menu close" })
		vim.keymap.set("i", "<TAB>", "<Plug>(CareSelectNext)", { desc = "Care menu select next" })
		vim.keymap.set("i", "<S-TAB>", "<Plug>(CareSelectPrev)", { desc = "Care menu select previous" })
		vim.keymap.set("i", "<c-x><c-f>",
			function()
				require("care").api.complete(function(name) return name == "cmp_path" end)
			end)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end,
}

return {
	"max397574/care.nvim",
	dependencies = {
		{
			"romgrk/fzy-lua-native",
		}
	},
	opts = {
		ui = {
			menu = {
				border = "none",
			},
			docs_view = {
				border = "none",
			}
		},
	},
	init = function()
		vim.keymap.set("i", "<C-n>", function()
			vim.snippet.jump(1)
		end, { desc = "snippet jump forward" })
		vim.keymap.set("i", "<C-p>", function()
			vim.snippet.jump(-1)
		end, { desc = "snippet jump backward" })
		vim.keymap.set("i", "<C-space>", function()
			require("care").api.complete()
		end, { desc = "open completion menu" })

		vim.keymap.set("i", "<CR>", "<Plug>(CareConfirm)", { desc = "Care menu confirm" })
		vim.keymap.set("i", "<C-e>", "<Plug>(CareClose)", { desc = "Care menu close" })
		vim.keymap.set("i", "<TAB>", "<Plug>(CareSelectNext)", { desc = "Care menu select next" })
		vim.keymap.set("i", "<S-TAB>", "<Plug>(CareSelectPrev)", { desc = "Care menu select previous" })

		vim.keymap.set("i", "<C-f>", function()
			if require("care").api.doc_is_open() then
				require("care").api.scroll_docs(4)
			else
				vim.api.nvim_feedkeys(vim.keycode("<C-f>"), "n", false)
			end
		end, { desc = "Care docs scroll down" })

		vim.keymap.set("i", "<C-d>", function()
			if require("care").api.doc_is_open() then
				require("care").api.scroll_docs(-4)
			else
				vim.api.nvim_feedkeys(vim.keycode("<C-f>"), "n", false)
			end
		end, { desc = "Care docs scroll up" })
	end,
}

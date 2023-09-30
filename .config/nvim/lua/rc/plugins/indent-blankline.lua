-- return {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	event = "BufWinEnter",
-- 	main = "ibl",
-- 	opts = {
-- 		-- exclude = {
-- 		-- 	filetypes = { "help", "man", "packer" }
-- 		-- },
-- 		-- show_trailing_blankline_indent = false,
-- 	},
-- 	-- cond = function()
-- 	-- 	return vim.api.nvim_buf_line_count(0) < 10000
-- 	-- end,
-- 	-- dependencies = "nvim-treesitter/nvim-treesitter",
-- }
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		exclude = {
			filetypes = { "help", "man", "packer" }
		},
		indent = {
			tab_char = '│'
		}
	}
}

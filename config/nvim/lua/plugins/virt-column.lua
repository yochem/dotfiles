return {
	"lukas-reineke/virt-column.nvim",
	opts = { char = "│" },
	cond = function()
		return vim.o.filetype ~= "json" and vim.api.nvim_buf_line_count(0) < 10000
	end,
	event = "VeryLazy"
}

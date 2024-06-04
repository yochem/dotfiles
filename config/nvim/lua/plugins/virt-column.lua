return {
	"lukas-reineke/virt-column.nvim",
	event = "BufWinEnter",
	opts = { char = "│" },
	cond = function()
		return vim.api.nvim_buf_line_count(0) < 10000
	end,
}

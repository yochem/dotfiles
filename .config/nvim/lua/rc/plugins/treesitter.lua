require("rc.autocommands").autocmd("FileType", {
	callback = function()
		local parsers = require("nvim-treesitter.parsers")
		local lang = parsers.get_buf_lang()
		if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
			vim.schedule_wrap(function()
				vim.cmd.TSInstall(lang)
			end)()
		end
	end,
	desc = "install missing TS grammar",
})

return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},
		})
	end,
}

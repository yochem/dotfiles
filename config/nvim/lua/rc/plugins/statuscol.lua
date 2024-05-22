local function folds_and_diagnostics(args)
	local diagnostics = vim.diagnostic.get(0)
	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.lnum == args.lnum - 1 then
			return "%s"
		end
	end
	return require("statuscol.builtin").foldfunc(args)
end

return {
	"luukvbaal/statuscol.nvim",
	branch = "0.10",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			ft_ignore = { "Trouble" },
			segments = {
				{ text = { folds_and_diagnostics, " " }, click = "v:lua.ScFa" },
				{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
				{ sign = {
					namespace = { "gitsign" },
					maxwidth = 1,
					colwidth = 1,
					fillchar = "│",
					fillcharhl = "@comment",
				}, click = "v:lua.ScSa" },
			},
		})
	end,
}

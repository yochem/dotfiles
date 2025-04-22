return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			ft_ignore = { "qf" },
			segments = {
				{
					sign = {
						namespace = { "jumpsigns", "diagnostic.signs" },
						maxwidth = 1,
						colwidth = 1,
						auto = true,
					},
					click = "v:lua.ScSa",
				},
				{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
				{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
				{
					sign = {
						namespace = { "gitsign" },
						maxwidth = 1,
						colwidth = 1,
						fillchar = "│",
						fillcharhl = "@comment",
					},
					click = "v:lua.ScSa",
				},
				{ text = { " " } },
			},
		})
	end,
}

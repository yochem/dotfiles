local builtin = require("statuscol.builtin")

require("statuscol").setup({
	relculright = true,
	ft_ignore = { "qf", "terminal" },
	segments = {
		{
			sign = {
				namespace = { "jumpsigns", "diagnostic.signs", ".*" },
				maxwidth = 1,
				colwidth = 1,
			},
			click = "v:lua.ScSa",
		},
		{ text = { "%C", " " }, click = "v:lua.ScFa" },
		{ text = { builtin.lnumfunc },      click = "v:lua.ScLa" },
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
	},
})

return {
	"navarasu/onedark.nvim",
	opts = {
		style = "darker",
		transparent = true,
		colors = {
			fg = "#fff",
		},
		highlights = {
			ColorColumn = { bg = "$none" },
			MsgArea = { fg = "$fg" },
			LineNrAbove = { fg = "#adbac7" },
			LineNrBelow = { fg = "#adbac7" },
			LineNr = { fg = "$fg" },
			StatusLine = { fg = "$fg" },
			Comment = { fg = "$light_grey" },
			EndOfBuffer = { fg = "$light_grey" },
			SpellBad = { fg = "$red", fmt="undercurl" },

			["@comment"] = { fg = "$light_grey" },
			["@field"] = { fg = "$fg" },
			["@operator.regex"] = { fg = "$purple" },
			["@character.special.regex"] = { fg = "$blue" },
			["@parameter"] = { fg = "$fg" },
			["@constant.builtin.python"] = { fg = "$orange", fmt="bold" },
			["@boolean.python"] = { fg = "$orange", fmt="bold" },
			["@constructor.python"] = { fg = "$yellow" },
		},
	},
	lazy = true,
}

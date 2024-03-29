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
			SpellBad = { fg = "NONE", fmt="undercurl" },

			["@comment"] = { fg = "$light_grey" },
			["@field"] = { fg = "$fg" },
			["@operator.regex"] = { fg = "$purple" },
			["@character.special.regex"] = { fg = "$blue" },
			["@constant.builtin.python"] = { fg = "$orange", fmt="bold" },
			["@boolean.python"] = { fg = "$orange", fmt="bold" },
			["@attribute.python"] = { fg = "$blue" },
			["@constructor.python"] = { fg = "$yellow" },

			["@text.title.1.markdown"] = { fg = "$fg", bg = "$orange", fmt = "bold" },
			["@text.title.2.markdown"] = { fg = "$orange", fmt = "bold,underline" },
			["@text.title.3.markdown"] = { fg = "$orange", fmt = "italic" },

			["@text.title.1.marker.markdown"] = { fg = "$grey", bg = "$orange", fmt = "bold" },
		},
	},
	lazy = true,
}

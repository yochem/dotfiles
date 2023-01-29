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
			["@comment"] = { fg = "$light_grey" },
			["@field"] = { fg = "$fg" },
		},
	},
	lazy = true,
}

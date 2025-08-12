vim.filetype.add({
	extension = {
		tex = "tex",
		tmpl = "gohtmltmpl",
		v = "v",
	},
	filename = {
		["v.mod"] = "v",
	},
	-- https://github.com/folke/snacks.nvim/blob/main/lua/snacks/bigfile.lua
	pattern = {
		[".*"] = {
			function(path, buf)
				if not path or not buf or vim.bo[buf].filetype == "bigfile" then
					return
				end
				if path ~= vim.api.nvim_buf_get_name(buf) then
					return
				end
				local size = vim.fn.getfsize(path)
				if size <= 0 then return end
				if size > 1.5e6 then
					return "bigfile"
				end
				local lines = vim.api.nvim_buf_line_count(buf)
				return (size - lines) / lines > 1000 and "bigfile" or nil
			end,
		},
	},
})

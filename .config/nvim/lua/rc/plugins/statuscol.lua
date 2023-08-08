local function diagnostic_line_index()
	local severity_signs = {
		'%#DiagnosticError#●%*',
		'%#DiagnosticWarn#●%*',
		'%#DiagnosticInfo#●%*',
	}
	local diagnostics = vim.diagnostic.get(0)
	local line_index = {}
	for _, diagnostic in ipairs(diagnostics) do
		line_index[diagnostic.lnum] = severity_signs[diagnostic.severity]
	end
	return line_index
end

local function folds_and_diagnostics(args)
	local ffi = require("statuscol.ffidef")
	local C = ffi.C
	local width = C.compute_foldcolumn(args.wp, 0)
	if width == 0 then return "" end

	local line_diagnostic = diagnostic_line_index()
	if line_diagnostic[args.lnum-1] then
		return line_diagnostic[args.lnum-1]
	end

	local foldinfo = C.fold_info(args.wp, args.lnum)
	local string = args.cul and args.relnum == 0 and "%#CursorLineFold#" or "%#FoldColumn#"
	local level = foldinfo.level

	if level == 0 then
		return string..(" "):rep(width).."%*"
	end

	local closed = foldinfo.lines > 0
	local first_level = level - width - (closed and 1 or 0) + 1
	if first_level < 1 then first_level = 1 end

	-- For each column, add a foldopen, foldclosed, foldsep or padding char
	local range = level < width and level or width
	for col = 1, range do
		if closed and (col == level or col == width) then
			string = string..args.fold.close
		elseif foldinfo.start == args.lnum and first_level + col > foldinfo.llevel then
			string = string..args.fold.open
		else
			string = string..args.fold.sep
		end
	end
	if range < width then string = string..(" "):rep(width - range) end

	return string.."%*"
end

return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{ text = { folds_and_diagnostics, " " }, click = "v:lua.ScFa" },
				{ text = { builtin.lnumfunc, "" }, click = "v:lua.ScLa" },
				{
					click = "v:lua.ScSa",
					sign = {
						name = { "GitSign*" },
						colwidth = 1,
						fillchar = '│',
						fillcharhl = '@comment',
					}
				},
			},
		})
	end,
}

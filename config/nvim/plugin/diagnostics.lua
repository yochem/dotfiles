vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '●',
			[vim.diagnostic.severity.WARN] = '●',
			[vim.diagnostic.severity.INFO] = '●',
			[vim.diagnostic.severity.HINT] = '●',
		},
	},
	underline = false,
	virtual_text = false,
	update_in_insert = false,
	severity_sort = true,
	chime = {
		trim = true,
		--- @param d vim.Diagnostic
		--- @return { [1]: string, [2]: string? }[]
		format = function(d)
			local sev = vim.diagnostic.severity[d.severity]
			-- Capitalize name
			local severity_name = sev:gsub('^(.)(%a*)', function(first, rest)
				return first:upper() .. rest:lower()
			end)

			return {
				{ severity_name, 'Diagnostic' .. severity_name},
				{ ': ' },
				{ d.message:match('^(.-)\n') or d.message },
				{ ' (' .. (d.source or 'unknown') .. ')', 'LineNr' },
			}
		end
	}
})

-- Show qf items with signs
on('QuickFixCmdPost', function (args)
	local is_loclist = vim.startswith(args.match, 'l')
	local list = is_loclist and vim.fn.getloclist(0) or vim.fn.getqflist()
	local items = vim.diagnostic.fromqflist(list)

	-- HACK: grep is INFO not ERROR
	if args.match:find('grep') then
		items = vim.iter(items):map(function (v)
			v.severity = vim.diagnostic.severity.INFO
			return v
		end):totable()
	end

	local per_buf = vim.iter(items):fold({}, function (acc, v)
		v.source = is_loclist and 'loclist' or 'quickfix'
		acc[v.bufnr] = acc[v.bufnr] or {}
		table.insert(acc[v.bufnr], v)
		return acc
	end)

	local ns = vim.api.nvim_create_namespace('yochem.qfdiagnostics')
	for buf, diagnostics in pairs(per_buf) do
		vim.diagnostic.set(ns, buf, diagnostics)
	end
end)

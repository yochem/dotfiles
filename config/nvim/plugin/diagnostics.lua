vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.INFO] = "●",
			[vim.diagnostic.severity.HINT] = "●",
		},
	},
	underline = false,
	virtual_text = false,
	update_in_insert = false,
	severity_sort = true,
	chime = {
		--- @param d vim.Diagnostic
		--- @return { [1]: string, [2]: string? }[]
		format = function(d)
			local sev = vim.diagnostic.severity[d.severity]
			-- Capitalize name
			local severity_name = sev:gsub("^(.)(%a*)", function(first, rest)
				return first:upper() .. rest:lower()
			end)

			return {
				{ severity_name, "Diagnostic" .. severity_name},
				{ ": " },
				{ vim.split(d.message, "\n")[1] },
				{ " (" .. d.source .. ")", "LineNr" },
			}
		end
	}
})

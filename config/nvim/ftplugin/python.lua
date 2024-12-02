vim.bo.expandtab = true

vim.keymap.set("n", "<leader>r", "<cmd>!python3 %:p<CR>", { buffer = true })

-- list all functions in the current buffer, type :<line-num> to jump to it
vim.keymap.set("n", ",f", function()
	vim.cmd.mark("x")
	vim.cmd.g([[/.*def .*\|^class /#]])
	vim.cmd.normal("`x")
end, {})

local function foldDocstrings()
	local query = [[
		(function_definition
			body: (block
				(expression_statement
					(string
						(string_start) @foo))))
	]]
	local ts = vim.treesitter
	local parser = ts.get_parser(0, "python")
	local tree = parser:parse()[1]
	local root = tree:root()

	local query_obj = ts.query.parse("python", query)

	for _, node, _, _ in query_obj:iter_captures(root, 0) do
		local start_row, start_col, end_row, end_col = node:range()
		vim.cmd(":" .. start_row + 1 .. "foldclose")
	end
end

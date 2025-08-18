vim.bo.expandtab = true

vim.api.nvim_buf_create_user_command(0, 'FoldDocstrings', function(args)
  local query = vim.treesitter.query.parse('python', [[
    (module (expression_statement (string) @docstring))
    (function_definition body: (block (expression_statement (string) @docstring)))
    (class_definition body: (block (expression_statement (string) @docstring)))
  ]])

  if args.range < 2 then
    args.line1 = nil
    args.line2 = nil
  end

  local tree = vim.treesitter.get_parser(0, 'python'):parse()[1]:root()
  for _, node, _, _ in query:iter_captures(tree, 0, args.line1, args.line2) do
    local start_line, _, end_line, _ = node:range()
    if vim.wo.foldmethod == 'manual' then
      vim.cmd.fold({ range = { start_line + 1, end_line } })
    else
      vim.cmd.foldclose({ range = { start_line + 1 } })
    end
  end
end, { range = true })

vim.keymap.set('n', 'zp', vim.cmd.FoldDocstrings, { buffer = true })

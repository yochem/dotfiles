vim.bo[0].tabstop = 2
vim.bo[0].shiftwidth = 2

function _G.fmt_json()
  local indent = vim.bo.expandtab and (' '):rep(vim.o.shiftwidth) or '\t'
  local lines = vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum + vim.v.count - 1, true)
  local o = vim.json.decode(table.concat(lines, '\n'))
  local stringified = vim.json.encode(o, { indent = indent })
  lines = vim.split(stringified, '\n')
  vim.api.nvim_buf_set_lines(0, vim.v.lnum - 1, vim.v.count, true, lines)
end
vim.o.formatexpr = 'v:lua.fmt_json()'

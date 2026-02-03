local ns = vim.api.nvim_create_namespace('yochem.treesitter-diagnostics')
local augroup = vim.api.nvim_create_augroup('yochem.treesitter-diagnostics', {})

--- @param buf integer Buffer number
--- @param pos integer[] Line number and stuff
--- @param message string? The error message
--- @return vim.Diagnostic
local function make_diagnostic(buf, pos, message)
  local lnum, col, end_lnum, end_col = unpack(pos)
  message = message or 'Syntax error'
  return {
    source = 'treesitter',
    namespace = ns,
    severity = vim.diagnostic.severity.ERROR,
    bufnr = buf,
    lnum = lnum,
    col = col,
    end_lnum = end_lnum,
    end_col = end_col,
    message = message,
  }
end

--- Name of node
--- @param node TSNode
--- @return string
local function node_type(node)
  return node:named() and node:type() or ('`%s`'):format(node:type())
end

--- @param node TSNode
--- @return string
local function node_context(node)
  local msg = ''
  if node:missing() then
    msg = msg .. (': missing `%s`'):format(node_type(node))
  end

  local prev = node:prev_sibling()
  if prev and prev:type() ~= 'ERROR' then
    msg = msg .. ' after ' .. node_type(prev)
  end

  local parent = node:parent()
  if parent and parent:type() ~= 'ERROR' and (prev == nil or prev:type() ~= parent:type()) then
    msg = msg .. ' in ' .. parent:type()
  end
  return msg
end


local function diagnose(args)
  if not vim.api.nvim_buf_is_valid(args.buf) then return end
  if not vim.diagnostic.is_enabled({ bufnr = args.buf }) then return end
  if vim.bo[args.buf].buftype ~= '' then return end

  local parser = vim.treesitter.get_parser(args.buf, nil, { error = false })
  if not parser then
    return
  end

  local nodes = {}
  local error_query = vim.treesitter.query.parse('query', '[(ERROR)] @_')
  parser:for_each_tree(function(tree, _)
    if tree:root():has_error() then
      for _, node in error_query:iter_captures(tree:root(), args.buf) do
        local parent = node:parent()
        -- skip nested
        if parent and not (parent:type() == 'ERROR' and parent:range() ~= node:range()) then
          table.insert(nodes, node)
        end
      end
    end
  end)

  local diagnostics = {}
  for _, node in ipairs(nodes) do
    local diagnostic = make_diagnostic(args.buf, { node:range() })
    diagnostic.message = diagnostic.message .. node_context(node)
    table.insert(diagnostics, diagnostic)
  end

  vim.diagnostic.set(ns, args.buf, diagnostics)
end

vim.api.nvim_create_autocmd({ 'FileType', 'TextChanged', 'InsertLeave' }, {
  desc = 'publish treesitter diagnostics',
  group = augroup,
  callback = vim.schedule_wrap(diagnose),
})

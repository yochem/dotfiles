-- brew install marksman
---@type vim.lsp.Config
return {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown' },
  root_markers = { '' },
}

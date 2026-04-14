-- go install github.com/wader/jq-lsp@latest
---@type vim.lsp.Config
return {
  cmd = { 'jq-lsp' },
  filetypes = { 'jq' },
}

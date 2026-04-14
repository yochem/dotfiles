-- v -e "$(curl -fsSL https://raw.githubusercontent.com/v-analyzer/v-analyzer/main/install.vsh)"
---@type vim.lsp.Config
return {
  cmd = { 'v-analyzer' },
  filetypes = { 'v', 'vsh', 'vv' },
  root_markers = { 'v.mod', '.git' },
}

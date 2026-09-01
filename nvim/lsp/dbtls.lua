---@type vim.lsp.Config
return {
  cmd = { 'dbt-language-server' },
  filetypes = { 'sql', 'yaml' },
  root_markers = { 'dbt_project.yml' },
}

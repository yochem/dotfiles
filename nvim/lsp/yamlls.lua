---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'yaml-language-server'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
  end,
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  root_markers = { '.git' },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      -- formatting disabled by default in yaml-language-server; enable it
      format = { enable = true },
      schemas = {
        -- gcp-data-hub
        ["utils/schemas/_dataset.schema.yaml"] = "**/bigquery/*/*/settings.yaml",
        ["utils/schemas/_storage.schema.yaml"] = "**/storage/*.yaml",
        -- dbt-projects
        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/dbt_yml_files-latest.json"] = {
          "/sources/**/*.yml",
          "!profiles.yml",
          "!dbt_project.yml",
          "!packages.yml",
          "!selectors.yml",
          "!profile_template.yml",
          "!package-lock.yml"
        },
        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/dbt_project-latest.json"] = {
          "dbt_project.yml"
        },
        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/selectors-latest.json"] = {
          "selectors.yml"
        },
        ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/packages-latest.json"] = {
          "packages.yml"
        }
      },
    },
  },
  on_init = function(client)
    --- https://github.com/neovim/nvim-lspconfig/pull/4016
    --- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
    --- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
    --- autocmd's which check this capability
    client.server_capabilities.documentFormattingProvider = true
  end,
}

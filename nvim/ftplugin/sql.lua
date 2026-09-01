vim.treesitter.start(0, 'jinja')

vim.bo[0].makeprg = 'uv run dbt run -q -s path:%'
vim.bo[0].softtabstop = 2
vim.bo[0].shiftwidth = 2

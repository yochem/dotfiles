vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = false,
		signs = true,
		update_in_insert = true,
		severity_sort = true,
})

return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func)
					vim.keymap.set('n', keys, func, { buffer = event.buf })
				end
				map("<leader>D", vim.lsp.buf.declaration)
				map("<leader>gd", vim.lsp.buf.definition)
				map("<leader>r", vim.lsp.buf.references)
				map("<leader>rn", vim.lsp.buf.rename)
				map("<leader>f", vim.lsp.buf.format)
				map("K", vim.lsp.buf.hover)
				map("<leader>[", vim.diagnostic.goto_prev)
				map("<leader>]", vim.diagnostic.goto_next)
				map("<leader>ca", vim.lsp.buf.code_action)
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						workspace = {
							checkThirdParty = false,
							library = {
								'${3rd}/luv/library',
								unpack(vim.api.nvim_get_runtime_file('', true)),
							},
						},
						completion = { callSnippet = 'Replace' },
					},
				},
			},

			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							mccabe = { enabled = true },
							pylsp_lsp_black = { enabled = true },
							pylsp_mypy = { enabled = true, live_mode = true },
							rope_autoimport = { enabled = true },
							rope_completion = { enabled = true, eager = false },
							ruff = { enabled = true, extendSelect = { "I" } }
						},
					},
				},
			},

			arduino_language_server = {},

			typst_lsp = {
				settings = {
					exportPdf = "never",
				}
			},

			gopls = {
				cmd = { "gopls", "serve" },
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true
					}
				},
			},

			bashls = {},
			clangd = {},
			cssls = {},
			erlangls = {},
			eslint = {},
			html = {},
			marksman = {},
			v_analyzer = {},
			jsonls = {},
		}


		for server_name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend(
				'force',
				{},
				capabilities,
				server.capabilities or {}
			)
			require('lspconfig')[server_name].setup(server)
		end
	end
}

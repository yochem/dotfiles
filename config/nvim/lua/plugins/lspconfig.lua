return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						hint = { enable = true },
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						completion = { callSnippet = "Replace" },
					},
				},
			},

			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pylsp_lsp_black = { enabled = true },
							pylsp_mypy = { enabled = true, live_mode = true },
							rope_autoimport = { enabled = true },
							rope_completion = { enabled = true, eager = false },
							ruff = { enabled = true, extendSelect = { "I" } },
						},
					},
				},
			},

			arduino_language_server = {},

			typst_lsp = {
				settings = {
					exportPdf = "never",
				},
			},

			gopls = {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
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
			jqls = {},
		}

		for server_name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end
	end,
}

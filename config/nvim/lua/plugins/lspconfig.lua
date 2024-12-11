vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method("textDocument/foldingRange") then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						hint = { enable = true },
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
								vim.env.XDG_CONFIG_HOME .. "/hammerspoon/Spoons/EmmyLua.spoon/annotations"
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
			jqls = {},
			jsonls = {},
			marksman = {},
			tinymist = {},
			v_analyzer = {},
		}

		for server_name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end
	end,
}

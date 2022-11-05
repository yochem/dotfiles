local lsp = require('lspconfig')
local coq = require('coq')

local function setup(server, options)
	local opt = vim.tbl_extend('keep', {
		on_attach = function(client, bufnr)
			require "lsp_signature".on_attach({
				hint_enable = false,
				doc_lines = 0,
				max_height = 1,
			}, bufnr)
		end
	}, options)
	lsp[server].setup(opt)
	lsp[server].setup(coq.lsp_ensure_capabilities(opt))
end

setup('pylsp', {
	settings = {
		pyls = {
			plugins = {
				mccabe = {enabled = false},
				pycodestyle = {enabled = false},
				pydocstyle = {enabled = false},
				pyflakes = {enabled = false},
				pylint = {enabled = false},
				yapf = {enabled = false},
				pyls_mypy = {enabled = false, live_mode = false}
			}
		}
	}
})

setup('sumneko_lua', {
	cmd = {
		'/Users/yochem/.local/bin/luals/bin/macOS/lua-language-server', '-E',
		'/Users/yochem/.local/bin/luals/main.lua'
	},
	settings = {
		Lua = {
			runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
			diagnostics = {globals = {'vim'}},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
				}
			}
		}
	}
})

setup('arduino_language_server', {})

setup('gopls', {
	cmd = {"gopls", "serve"},
	settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
	root_dir = lsp.util.root_pattern(".")
})

setup('bashls', {filetypes = {'sh'}})
setup('clangd', {cmd = {'clangd'}})
setup('cssls', {root_dir = lsp.util.root_pattern("index.html")})
setup('erlangls', {})
setup('eslint', {})
setup('html', {})
setup('vls', {})
setup('jsonls', {})
setup('texlab', {
	settings = {
		build = {args = {"-pvc", "-view=pdf", "%f"}, isContinuous = true}
	}
})


-- use popups instead of virtual text on the same line
vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		severity_sort = true
	})

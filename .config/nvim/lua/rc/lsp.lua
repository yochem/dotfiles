local lsp = require('lspconfig')
local coq = require('coq')

local function setup(server, options)
	lsp[server].setup(options)
	lsp[server].setup(coq.lsp_ensure_capabilities(options))
end

-- setup('pylsp', {
-- 	settings = {
-- 		pyls = {
-- 			plugins = {
-- 				mccabe = {enabled = false},
-- 				pycodestyle = {enabled = false},
-- 				pydocstyle = {enabled = false},
-- 				pyflakes = {enabled = false},
-- 				pylint = {enabled = false},
-- 				yapf = {enabled = false},
-- 				pyls_mypy = {enabled = false, live_mode = false}
-- 			}
-- 		}
-- 	}
-- })
lsp.pylsp.setup({})
lsp.pylsp.setup(coq.lsp_ensure_capabilities({}))

lsp.sumneko_lua.setup {
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
}

lsp.arduino_language_server.setup {}

lsp.gopls.setup {
	cmd = {"gopls", "serve"},
	settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
	root_dir = lsp.util.root_pattern(".")
}

lsp.bashls.setup {filetypes = {'sh'}}
lsp.clangd.setup {cmd = {'clangd'}}
lsp.cssls.setup {root_dir = lsp.util.root_pattern("index.html")}
lsp.erlangls.setup {}
lsp.eslint.setup {}
lsp.html.setup {}

lsp.jsonls.setup {}
lsp.texlab.setup {
	settings = {
		build = {args = {"-pvc", "-view=pdf", "%f"}, isContinuous = true}
	}
}


-- use popups instead of virtual text on the same line
vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		severity_sort = true
	})

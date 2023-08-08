local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function setup(server, options)
	local opt = vim.tbl_extend("keep", {
		capabilities = capabilities,
	}, options)
	lsp[server].setup(opt)
end

setup("pylsp", {
	root_dir = function()
		return "."
	end,
	settings = {
		pylsp = {
			plugins = {
				flake8 = { ignore = { "E501" } },
				mccabe = { enabled = true },
				pycodestyle = { enabled = false },
				pydocstyle = { enabled = false },
				pyflakes = { enabled = false },
				pylint = { enabled = true },
				pylsp_lsp_black = { enabled = true },
				pylsp_mypy = { enabled = true, live_mode = true },
				rope_autoimport = { enabled = true },
				rope_completion = { enabled = true, eager = true },
				yapf = { enabled = false },
			},
		},
	},
})

setup("lua_ls", {
	cmd = {
		"/Users/yochem/.local/bin/luals/bin/macOS/lua-language-server",
		"-E",
		"/Users/yochem/.local/bin/luals/main.lua",
	},
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

setup("arduino_language_server", {})

setup("gopls", {
	cmd = { "gopls", "serve" },
	settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
	root_dir = lsp.util.root_pattern("."),
})

setup("bashls", { filetypes = { "sh" } })
setup("clangd", { cmd = { "clangd" } })
setup("cssls", { root_dir = lsp.util.root_pattern("index.html") })
setup("erlangls", {})
setup("eslint", {})
setup("html", {})
setup("vls", {
	cmd = { "v", "ls", "--silent" },
})
setup("jsonls", {})
setup("texlab", {
	settings = {
		build = { args = { "-pvc", "-view=pdf", "%f" }, isContinuous = true },
	},
})

-- use popups instead of virtual text on the same line
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false,
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})

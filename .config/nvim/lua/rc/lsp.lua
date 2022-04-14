local lsp = require('lspconfig')

lsp.pylsp.setup {
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
}

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
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true
    })
    --
-- default configuration
lsp.util.default_config = vim.tbl_extend("force", lsp.util.default_config, {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

vim.cmd[[
sign define DiagnosticSignError text=● texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text=● texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text=● texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=● texthl=DiagnosticSignHint linehl= numhl=
]]

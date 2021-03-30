local lsp = require('lspconfig')

-- default configuration
lsp.util.default_config = vim.tbl_extend("force", lsp.util.default_config, {
    on_attach = require'completion'.on_attach
})

lsp.pyls.setup {
    settings = {
        pyls = {
            plugins = {
                mccabe = {enabled = false},
                pycodestyle = {enabled = false},
                pydocstyle = {enabled = false},
                pyflakes = {enabled = false},
                pylint = {enabled = true},
                yapf = {enabled = false},
                pyls_mypy = {enabled = true, live_mode = false}
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

lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    root_dir = lsp.util.root_pattern(".")
}

lsp.bashls.setup {filetypes = {'sh'}}
lsp.cssls.setup {root_dir = lsp.util.root_pattern("index.html")}
lsp.jsonls.setup {}
lsp.tsserver.setup {}
lsp.erlangls.setup {}
lsp.clangd.setup {cmd = {'/usr/local/Cellar/llvm/11.1.0/bin/clangd'}}

-- use popups instead of virtual text on the same line
vim.cmd [[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = false
    })

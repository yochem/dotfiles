local lsp = require('lspconfig')

lsp.pyls.setup{
    on_attach=require'completion'.on_attach;
    settings={
        pyls={
            plugins={
                mccabe={enabled=false};
                pycodestyle={enabled=false};
                pydocstyle={enabled=false};
                pyflakes={enabled=false};
                pylint={enabled=false};
                yapf={enabled=false};
                pyls_mypy={enabled=true; live_mode=false}
            }
        }
    }
}

lsp.sumneko_lua.setup {
    cmd = {
        '/Users/yochem/.local/bin/luals/bin/macOS/lua-language-server',
        '-E',
        '/Users/yochem/.local/bin/luals/main.lua'};
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}

lsp.bashls.setup{on_attach=require'completion'.on_attach; filetypes={'sh'}}
lsp.clangd.setup{on_attach=require'completion'.on_attach}
lsp.gopls.setup{
    on_attach=require'completion'.on_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {unusedparams = true},
            staticcheck = true,
        },
    },
}
lsp.jsonls.setup{on_attach=require'completion'.on_attach}
lsp.texlab.setup{on_attach=require'completion'.on_attach}
lsp.tsserver.setup{on_attach=require'completion'.on_attach}

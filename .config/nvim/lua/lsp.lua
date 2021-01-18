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

lsp.bashls.setup{on_attach=require'completion'.on_attach; filetypes={'sh'}}
lsp.clangd.setup{on_attach=require'completion'.on_attach}
lsp.gopls.setup{on_attach=require'completion'.on_attach}
lsp.jsonls.setup{on_attach=require'completion'.on_attach}
lsp.texlab.setup{on_attach=require'completion'.on_attach}
lsp.tsserver.setup{on_attach=require'completion'.on_attach}

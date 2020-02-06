" open the corresponding header or source file in a split
if (expand("%:e") == 'c')
    nnoremap <leader>h :sp %:r.h<CR>
else
    nnoremap <leader>h :sp %:r.c<CR>
endif

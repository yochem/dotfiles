" open the corresponding header or source file in a split
if (expand("%:e") == 'c')
    nnoremap <leader>h :sp %:r.h<CR>
else
    nnoremap <leader>h :sp %:r.c<CR>
endif

" list all structs and functions in the current buffer, type :<line-num> to
" jump
function! FindFuncs()
    exe 'g/^[a-z].*[{,]$/'
endfunction
nnoremap <leader>f :call FindFuncs()<CR>

" run the python file
nnoremap <leader>r :!python3 %:p<CR>

" remap flake8 key
nnoremap <buffer> <leader>p :call flake8#Flake8()<CR>

" zz is easier to type
nnoremap zz za

" list all structs and functions in the current buffer, type :<line-num> to
" jump
function! FindFuncs()
    exe 'g/^def .*:$/'
endfunction
nnoremap <leader>f :call FindFuncs()<CR>

" run the python file
nnoremap <buffer> <leader>r :!python3 %:p<CR>

" list all structs and functions in the current buffer, type :<line-num> to
" jump
function! FindFuncs(deep)
    normal mx
    if a:deep
        exe 'g/def \|^class /#'
    else
        exe 'g/^def \|^class /#'
    endif
    normal `x
endfunction

nnoremap <silent> <buffer> <leader>F :call FindFuncs(0)<CR>
nnoremap <silent> <buffer> <leader>f :call FindFuncs(1)<CR>

" fold docstrings beautifully
setlocal foldenable
setlocal fillchars+=fold:\ 

nnoremap <leader>b :silent !black %<CR>
let b:ale_linters = []

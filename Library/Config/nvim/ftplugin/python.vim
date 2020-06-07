" run the python file
nnoremap <buffer> <leader>r :!python3 %:p<CR>

" list all structs and functions in the current buffer, type :<line-num> to
" jump
function! FindFuncs(deep)
    normal mx
    if a:deep
        exe 'g/def\|^class/#'
    else
        exe 'g/^def\|^class/#'
    endif
    normal `x
endfunction

nnoremap <buffer> <leader>F :call FindFuncs(0)<CR>
nnoremap <buffer> <leader>f :call FindFuncs(1)<CR>

" don't need that much linting with Python
" let b:ale_linters = []
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

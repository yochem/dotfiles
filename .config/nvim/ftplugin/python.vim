" run the python file
nnoremap <leader>r :!python3 %:p<CR>

" zz is easier to type
nnoremap zz za

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

nnoremap <leader>f :call FindFuncs(0)<CR>
nnoremap <leader>F :call FindFuncs(1)<CR>

" don't need that much linting with Python
let b:ale_linters = ['autopep8', 'pylint', 'flake8']
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

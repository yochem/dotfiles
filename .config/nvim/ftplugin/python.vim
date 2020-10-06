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

nnoremap <buffer> <leader>F :call FindFuncs(0)<CR>
nnoremap <buffer> <leader>f :call FindFuncs(1)<CR>

" docstring as text object
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'd': {'pair': [{'o': '"""', 'c': '"""'}]},
    \ })

" fold docstrings beautifully
setlocal foldmethod=syntax
setlocal foldenable
setlocal foldtext=MyFoldText()
setlocal fillchars+=fold:\ 
function MyFoldText()
    let line0 = getline(v:foldstart)
    if line0 =~ '\v.*""".+'
        return v:folddashes . line0
    else
        return v:folddashes . getline(v:foldstart+1)
    endif
endfunction

" don't need that much linting with Python
" let b:ale_linters = ['autopep8', 'mypy', 'pylint']
let b:ale_linters = []
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

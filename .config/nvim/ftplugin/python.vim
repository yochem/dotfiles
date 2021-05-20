" run the python file
nnoremap <buffer> <leader>r :!python3 %:p<CR>

" format it right using gq
set formatprg=python-format

" list all structs and functions in the current buffer, type :<line-num> to
" jump
function! FindFuncs()
    normal mx
    exe 'g/def .*:$\|^class /#'
    normal `x
endfunction

nnoremap <buffer> <space>f :call FindFuncs()<CR>

" fold docstrings beautifully
setlocal foldenable
setlocal fillchars+=fold:\ 

nnoremap <leader>b :silent !black %<CR>

setlocal foldmethod=syntax
setlocal foldtext=FoldText()
setlocal fillchars=

function! s:Strip(string)
  return substitute(a:string, '^[[:space:][:return:][:cntrl:]]\+\|[[:space:][:return:][:cntrl:]]\+$', '', '')
endfunction

" Extract the first line of a multi-line comment to use as the fold snippet
function! FoldText()
  let l:snippet = getline(v:foldstart)
  if len(s:Strip(l:snippet)) == 3
    let l:snippet = strpart(l:snippet, 1) . s:Strip(getline(v:foldstart + 1))
  endif
  return l:snippet
endfunction

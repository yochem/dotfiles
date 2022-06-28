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

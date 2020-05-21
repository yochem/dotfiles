" Go to next chapter
nnoremap <silent> N /^[A-Z]<CR>:noh<CR>
nnoremap <silent> P ?^[A-Z]<CR>:noh<CR>

" show sections
nnoremap <silent> S :g/^\w<CR>

" find the description of a flag
command! -nargs=1 Flag /^     -<args>

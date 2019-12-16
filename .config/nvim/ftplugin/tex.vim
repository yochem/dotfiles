function CreateBib()
    let _fn=expand('%:r')
    execute '!pdflatex %; bibtex ' . _fn . '; pdflatex %; pdflatex %'
endfunction

setlocal textwidth=78
nnoremap <leader>r :!pdflatex %<CR>
nnoremap <leader>w :silent !pdflatex %<CR>
nnoremap <leader>W :call CreateBib()<CR>

au VimLeave *.tex silent !rm <afile>:r.{aux,log,out,bbl,blg}

" stop all that folding
let g:Tex_FoldedSections = ''
let g:Tex_FoldedEnvironments = 'figure,titlepage'
let g:Tex_FoldedMisc = ''

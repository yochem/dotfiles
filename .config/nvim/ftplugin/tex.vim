function CreateBib()
    let _fn=expand('%:r')
    execute '!pdflatex %; bibtex ' . _fn . '; pdflatex %; pdflatex %'
endfunction

setlocal textwidth=78

" Let user specify latex engine by '% engine' on first line
function LatexRenderer()
    " default
    let render = 'pdflatex'

    let first_line = getline(1)
    if first_line =~ "% .*tex"
        let render = split(first_line)[1]
    endif

    execute '!' . render . ' %'
endfunction

nnoremap <leader>r :call LatexRenderer()<CR>
nnoremap <leader>w :silent call LatexRenderer()<CR>
nnoremap <leader>W :call CreateBib()<CR>

au VimLeave *.tex silent !rm <afile>:r.{aux,log,out,bbl,blg}

" stop all that folding
let g:Tex_FoldedSections = ''
let g:Tex_FoldedEnvironments = 'figure,titlepage'
let g:Tex_FoldedMisc = ''

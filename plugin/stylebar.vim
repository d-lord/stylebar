" =========================
" Style marking for tutors
" =========================
augroup style
    autocmd!
    " if we make these :set then it works, but globally. need to figure out
    " buffer scope
    autocmd BufReadPost *.c.styled setlocal statusline=%!GetViolationString()
    autocmd BufReadPost *.h.styled setlocal statusline=%!GetViolationString()
augroup END

let g:style_annotations = [
	\['B', 'BRACES'],
	\['W', 'WHITESPACE'],
	\['C', 'COMMENTS'],
	\['N', 'NAMING'],
	\['O', 'OVERALL'],
	\['L', 'LINELENGTH'],
	\['I', 'INDENTATION']
	\]

function! CalcViolations()
    let g:style_scores = {}
    " this line needs expanding: getline() is the current buffer, we want all
    " buffers matching *.(c|h).styled.
    " at that point it's probably worth reducing the recalc count.
    for line in getline(1, '$')
	for annotation in g:style_annotations
	    if line =~# '^\[' . annotation[1] . '\]'
		let g:style_scores[annotation[1]] = get(g:style_scores, annotation[1], 0) + 1
	    endif
	endfor
    endfor
endfunction

function! GetViolationString()
    call CalcViolations()
    let ret = ''
    for annotation in g:style_annotations
	let ret .= '[' . annotation[0] . ':' . get(g:style_scores, annotation[1], 0) . '] '
    endfor
    return ret
endfunction

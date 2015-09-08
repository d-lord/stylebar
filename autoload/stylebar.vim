" ==============================
" Style marking for tutors: dev
" ==============================
augroup style
        autocmd!
        autocmd BufReadPost *.c.styled setlocal statusline=%!GetViolationString()
        autocmd InsertLeave *.c.styled setlocal statusline=%!GetViolationString()
augroup END
function! GetViolations()
        let b:violations_braces = 0
        let b:violations_whitespace = 0
        let b:violations_comments = 0
        let b:violations_naming = 0
        let b:violations_overall = 0
        let b:violations_linelength = 0
        let b:violations_indentation = 0
        for line in getline(1, '$')
                if line =~# '\[BRACES\]'
                        let b:violations_braces = b:violations_braces + 1
                endif
                if line =~# '^\[WHITESPACE\]'
                        let b:violations_whitespace = b:violations_whitespace + 1
                endif
                if line =~# '^\[COMMENTS\]'
                        let b:violations_comments = b:violations_comments + 1
                endif
                if line =~# '^\[NAMING\]'
                        let b:violations_naming = b:violations_naming + 1
                endif
                if line =~# '^\[OVERALL\]'
                        let b:violations_overall = b:violations_overall + 1
                endif
                if line =~# '^\[LINELENGTH\]'
                        let b:violations_linelength = b:violations_linelength + 1
                endif
                if line =~# '^\[INDENTATION\]'
                        let b:violations_indentation = b:violations_indentation + 1
                endif
        endfor
endfunction
function! GetViolationString()
        call GetViolations()
        return "".
        \ "[B: " . b:violations_braces . "] " .
        \ "[W: " . b:violations_whitespace . "] " .
        \ "[C: " . b:violations_comments . "] " .
        \ "[N: " . b:violations_naming . "] " .
        \ "[O: " . b:violations_overall . "] " .
        \ "[L: " . b:violations_linelength . "] " .
        \ "[I: " . b:violations_indentation . "] "
endfunction

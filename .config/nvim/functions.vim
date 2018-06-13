
function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

function! Underline()
    silent! normal Yp
    silent! s/./-/g
    silent! noh
endfunction
command! Underline call Underline()

function! Mirror(dict)
    for [key, value] in items(a:dict)
        let a:dict[value] = key
    endfor
    return a:dict
endfunction

function! S(number)
    return submatch(a:number)
endfunction

function! SwapWords(word1, word2, ...) range
    let dict = {a:word1 : a:word2}
    let words = keys(dict) + values(dict)
    let words = map(words, 'escape(v:val, "|")')
    if(a:0 == 1)
        let delimiter = a:1
    else
        let delimiter = '/'
    endif
    let pattern = '\v(' . join(words, '|') . ')'
    exe "'<,'>" 's' . delimiter . pattern . delimiter
        \ . '\=' . string(Mirror(dict)) . '[S(0)]'
        \ . delimiter . 'g'
endfunction
command! -nargs=* -range SwapWords call SwapWords(<f-args>)

" remove all spaces at the end of a line
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction
nnoremap <Leader>c :call TrimWhitespace()<CR>

function! ChompNewline(line)
    return substitute(a:line, '\n\+$', '', '')
endfunction

function! FindMatchExtension()
    let filename=expand('%:t')
    if match(filename, '\.c') > 0
        let target_name=substitute(filename, '\.c\(.*\)', '.h*', '')
        let target_type='header'
    elseif match(filename, '\.h') > 0
        let target_name=substitute(filename, '\.h\(.*\)', '.c*', '')
        let target_type='source'
    else
        echoerr 'Only works for *.h(*)/*.c(*) variations with simple names'
        return 0
    endif

    let dirname=fnamemodify(expand('%:p'), ':h')
    let cmd='find ' . dirname . " . -type f -iname \'" . target_name . "\' -print -quit"
    let g:find_res=ChompNewline(system(cmd))
    let find_res = g:find_res

    echo find_res

    if filereadable(find_res) == 0
        echoerr 'Could not find matching ' . target_type . ' file for: ' . dirname . '/' . filename
        return 0
    endif

    let full_path_no=bufnr(find_res)
    if full_path_no != -1
        exe 'b' string(full_path_no)
        return 0
    endif
    let rel_path=fnamemodify(find_res, ':.')
    let rel_path_no=bufnr(rel_path)
    if rel_path_no != -1
        exe 'b' string(rel_path_no)
        return 0
    endif

    exe 'e ' find_res
endfun
nnoremap <Leader>o :call FindMatchExtension()<CR>


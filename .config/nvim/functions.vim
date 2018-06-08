
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


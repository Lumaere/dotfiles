
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


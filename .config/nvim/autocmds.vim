
augroup Mkdir
    " Make directory before writing if one doesn't exist
    autocmd!
    autocmd BufWritePre *
        \ if !isdirectory(expand("<afile>:p:h")) |
                \ call mkdir(expand("<afile>:p:h"), "p") |
        \ endif
augroup END

" expand terminal scrollback
autocmd TermOpen * setlocal scrollback=10000

" insert when going to term and stop when leaving
" autocmd BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave term://* stopinsert

" template implementation files
autocmd BufNewFile,BufRead *.tpp   set syntax=cpp
autocmd BufNewFile,BufRead *.tpp   set filetype=cpp

" augroup AutoSaveFolds
"     autocmd!
"     autocmd BufWinLeave * mkview
"     autocmd BufWinEnter * silent loadview
" augroup END


"
" command line remapping
cnoreabbrev bd bp<bar>bd #

nnoremap <up> :echo "Use K"<CR>
nnoremap <down> :echo "Use J"<CR>
nnoremap <left> :echo "Use H"<CR>
nnoremap <right> :echo "Use L"<CR>
" inoremap <BS> <Nop>

" make a new file if not found
nnoremap gf :e <cfile><CR>

" easier scroll for me
nnoremap <C-f> <C-u>

" buffer switching
nnoremap <Leader>l :ls<CR>
nnoremap <Leader><Leader> :b#<CR>

" writing and quiting
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :wq<CR>

" make only split
" nnoremap <Leader>o :only<CR>

" echo current filename
nnoremap <Leader>p :echo expand('%:p')<CR>

" search and replace
nnoremap <Leader>s :%s/\\\<<C-r><C-w>\\\>//g<Left><Left>
nnoremap <Leader>S :%s/\\\<<C-r><C-a>\\\>//g<Left><Left>

" when searching use regex closer to perl
nnoremap / /\\v
vnoremap / /\\v

" terminal settings
tnoremap <ESC> <C-\><C-n>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


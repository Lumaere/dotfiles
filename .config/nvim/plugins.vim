
" Fancy status airline things ---------------------------
set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
" let g:airline_theme='kolor'
let g:airline_theme='papercolor'
" let g:airline_theme='bubblegum' " NOTE: this is a custom theme so save this
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 0  " set to 1 to turn on
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#obsession#enabled = 1
" let g:airline#extensions#syntastic#enabled = 0


let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" don't really care about encoding/format
let g:airline_section_y=''
" show obsession
let g:airline_section_z= airline#section#create(['%{ObsessionStatus(''$'', '''')} ', 'ℭ %c'])

" netrw plugin settings ---------------------------------
let g:netrw_liststyle = 3  " tree

" Ctrl-P settings ---------------------------------------
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_switch_buffer = 0


" deoplete settings -------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'

inoremap <expr><C-l>     deoplete#refresh()

" echodoc settings --------------------------------------
let g:echodoc#enable_at_startup = 1
set noshowmode


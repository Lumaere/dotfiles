
" JSON pretty print
command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool

" splits around term command
command! -nargs=* SplitTerm split | terminal <args>
command! -nargs=* VsplitTerm vsplit | terminal <args>
command! -nargs=* Spt split | terminal <args>
command! -nargs=* Vst vsplit | terminal <args>


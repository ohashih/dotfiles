let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#454545 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#454545 ctermbg=235

set background=dark
colorscheme hybrid
"colorscheme iceberg
highlight DiffAdd    gui=none guifg=none    guibg=#003366
highlight DiffDelete gui=bold guifg=#660000 guibg=#660000
highlight DiffChange gui=none guifg=none    guibg=#006666
highlight DiffText   gui=none guifg=none    guibg=#013220

" カーソル行を強調表示しない
set nocursorline
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter,InsertLeave * set cursorline!

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#default_hidden=1
let g:fern#disable_default_mappings = 1

function! FernInit() abort
    nmap <buffer> v <Plug>(fern-action-open:side)
    nmap <buffer> M <Plug>(fern-action-new-dir)
    nmap <buffer> ! <Plug>(fern-action-hidden:toggle)
    nmap <buffer> - <Plug>(fern-action-mark:toggle)
    vmap <buffer> - <Plug>(fern-action-mark:toggle)
    nmap <buffer> C <Plug>(fern-action-clipboard-copy)
    nmap <buffer> X <Plug>(fern-action-clipboard-move)
    nmap <buffer> P <Plug>(fern-action-clipboard-paste)
    nmap <buffer> h <Plug>(fern-action-collapse)
    nmap <buffer> c <Plug>(fern-action-copy)
    nmap <buffer> <leader>h <Plug>(fern-action-leave)
    nmap <buffer> m <Plug>(fern-action-move)
    nmap <buffer> N <Plug>(fern-action-new-file)
    nmap <buffer> <cr> <Plug>(fern-action-open-or-enter)
    nmap <buffer> l <Plug>(fern-action-open-or-expand)
    nmap <buffer> s <Plug>(fern-action-open:select)
    nmap <buffer> t <Plug>(fern-action-open:tabedit)
    nmap <buffer> <C-l> <Plug>(fern-action-reload)
    nmap <buffer> r <Plug>(fern-action-rename)
    nmap <buffer> i <Plug>(fern-action-reveal)
    nmap <buffer> D <Plug>(fern-action-trash)
    nmap <buffer> y <Plug>(fern-action-yank)
    nmap <buffer> gr <Plug>(fern-action-grep)
    nmap <buffer> d <Plug>(fern-action-remove)
    nmap <buffer> B <Plug>(fern-action-save-as-bookmark)
    nmap <buffer> cd <Plug>(fern-action-tcd)
    nmap <buffer> <C-h> <C-w>h
    nmap <buffer> <C-l> <C-w>l
  endfunction
  augroup FernEvents
    autocmd!
    autocmd FileType fern call FernInit()
  augroup END


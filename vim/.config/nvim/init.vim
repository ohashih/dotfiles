let $LANG='en_US.UTF-8'
let mapleader = "\<SPACE>"
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')

if &compatible
  set nocompatible
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  if !has('nvim')
  endif
  call dein#add('cocopon/iceberg.vim')
  call dein#add('w0ng/vim-hybrid')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy':0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy':1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" 各設定ファイル読み込み
runtime! ./rc/color.vim
runtime! ./rc/function.vim
runtime! ./rc/option.vim
runtime! ./rc/tab.vim
runtime! ./rc/keybind.vim

if executable('elm-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'elm-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'elm-language-server --stdio']},
    \ 'initialization_options': {
      \ 'runtime': 'node',
      \ 'elmPath': 'elm',
      \ 'elmFormatPath': 'elm-format',
      \ 'elmTestPath': 'elm-test',
      \ 'rootPatterns': 'elm.json'
      \ },
    \ 'whitelist': ['elm'],
    \ })
  autocmd BufWritePre *.elm LspDocumentFormat
endif

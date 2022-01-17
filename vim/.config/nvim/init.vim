let $LANG='en_US.UTF-8'
let g:python3_host_prog = expand('/usr/local/bin/python3')

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
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('w0ng/vim-hybrid')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('ayu-theme/ayu-vim')
  call dein#add('cocopon/iceberg.vim')
  call dein#add('prettier/vim-prettier', {'do': 'yarn install', 'for': 'markdown'})
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('yuki-yano/fzf-preview.vim', { 'rev': 'release/rpc' })
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

if executable("typescript-language-server")
  let s:npm_root = trim(system("npm root -g"))

  let s:has_typescript_deno_plugin = isdirectory(s:npm_root . "/typescript-deno-plugin")
  let s:plugins = s:has_typescript_deno_plugin
    \ ? [{ "name": "typescript-deno-plugin", "location": s:npm_root }]
    \ : []
  augroup LspTypeScript
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \   "name": "typescript-language-server",
    \   "cmd": {server_info -> ["typescript-language-server", "--stdio"]},
    \   "root_uri": {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \   "whitelist": ["typescript", "typescript.tsx"],
    \   "initialization_options": { "plugins": s:plugins },
    \ })
  augroup END
endif

"autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
"autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>FzfPreviewGitStatusRpc<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>FzfPreviewGitActionsRpc<CR>
nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewBuffersRpc<CR>
nnoremap <silent> [fzf-p]B     :<C-u>FzfPreviewAllBuffersRpc<CR>
nnoremap <silent> [fzf-p]o     :<C-u>FzfPreviewFromResourcesRpc buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumpsRpc<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>FzfPreviewChangesRpc<CR>
nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>FzfPreviewProjectGrepRpc<Space>
xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrepRpc<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTagsRpc<CR>
nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFixRpc<CR>
nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationListRpc<CR>

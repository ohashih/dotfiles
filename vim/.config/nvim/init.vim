let $LANG='en_US.UTF-8'
let g:python3_host_prog = expand('~/')
let mapleader = "\<Space>"
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
  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('w0ng/vim-hybrid')
  call dein#add('cocopon/iceberg.vim')
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

set clipboard=unnamed
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set shiftround
set hls
nnoremap <silent> <S-j> :split<CR>
nnoremap <silent> <S-l> :vsplit<CR>
nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 折り返し行移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 20行ずつ移動
nnoremap <C-d> 20j
vnoremap <C-d> 20j
nnoremap <C-u> 20k
vnoremap <C-u> 20k
inoremap <silent> jj <ESC>:<C-u>w<CR>

nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>"

set number

set background=dark
"colorscheme hybrid
colorscheme iceberg

let g:tablineclosebutton=1

" ========== Character code =======
" 文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8
" 改行コードの自動判別
set fileformat=unix
set ambiwidth=double

" ========== Base Config ==========
" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

" バッファが編集中でもその他のファイルを開けるように
set hidden

" ターミナル接続を高速化
set ttyfast

" 改行時自動インデント
set smartindent

" インクリメントサーチを有効にする
set incsearch

" ハイライトサーチを有効にする
set hlsearch

" 検索時大文字小文字を区別しない
set ignorecase

" 検索時に大文字を入力した場合ignorecaseが無効になる
set smartcase

" カーソルラインを表示する
set cursorline

" ファイル更新で自動で読み直す
set autoread

" 補完ウィンドウの設定
set completeopt=menuone

" ビープ音を可視化
"set visualbell

" 括弧入力時の対応する括弧を表示
set showmatch

" 対応括弧の表示秒数を3秒にする
"set matchtime=3

" ステータスラインを常に表示
set laststatus=2

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" タイトルを表示
set title

" カーソルの行数表示
set cursorline

" マウス操作を有効にする
set mouse=a

" タイムアウト時間設定
set timeout timeoutlen=1000 ttimeoutlen=50

" wildmenuを有効にする
set wildmenu
set wildmode=full

" 保存するコマンド履歴の数
set history=500

" バックスペースキーの有効化
"set backspace=indent,eol,start

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" ========== Key Map ==============

" 入力モード中に素早くJJと入力した場合はESCとみなす
inoremap jj <Esc>

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

" Shift + 矢印でウィンドウサイズを変更 TODO
nnoremap <w-Left>  <C-w><<CR>
nnoremap <w-Right> <C-w><CR>
nnoremap <w-Up>    <C-w>-<CR>
nnoremap <w-Down>  <C-w>+<CR>

" カーソルラインの位置を保存する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" Setting tabpage
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

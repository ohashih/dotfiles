set clipboard=unnamed
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
set autoindent
set smartindent
set cindent
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set shiftround
set hls
set number
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

"TAB,EOFなどを可視化する
set list
set listchars=tab:>-,extends:<,trail:-

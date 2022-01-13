let mapleader = "\<Space>"

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

" Control + S で保存する
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q!<CR>
inoremap <C-s> <ESC>:w<CR>a
inoremap <C-q> <ESC>:q!<CR>

nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>"

" 入力モード中に素早くJJと入力した場合はESCとみなす
inoremap jj <Esc>

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" コマンドモードで高速移動
nnoremap <M-Right> <S-a>
nnoremap <M-Left> <S-i>

"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <M-Right> <ESC><S-a>

inoremap <M-Left> <ESC><S-i>

" Shift + 矢印でウィンドウサイズを変更 TODO
nnoremap <g-Left>  <C-w><<CR>
nnoremap <g-Right> <C-w><CR>
nnoremap <g-Up>    <C-w>-<CR>
nnoremap <g-Down>  <C-w>+<CR>

" buffer
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

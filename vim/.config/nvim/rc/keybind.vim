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

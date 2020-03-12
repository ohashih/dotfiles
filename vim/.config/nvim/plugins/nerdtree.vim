let g:NERDTreeDirArrows = 1
let NERDTreeWinSize=40
let NERDTreeShowHidden = 1
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeWinPos = "left"
"autocmd vimenter * NERDTree

nnoremap [nerd]   <Nop>
nmap <Space>n [nerd]

" NERDTreeTabsを利用するように変更
nnoremap <silent><C-e> :NERDTreeTabsToggle<CR>
nnoremap <silent>[nerd]f :call NERDTreeFindAndHighlight()<CR>
nnoremap <silent>[nerd]h :call NERDTreeHighlight()<CR>


" Findしつつファイルをハイライトする
function! NERDTreeFindAndHighlight()
  NERDTreeFind
  :setlocal isk+=.
  normal! 0w
  exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
  :setlocal isk-=.
endfunction

" 開いてるファイルをハイライトする
function! NERDTreeHighlight()
  :call NERDTreeFindAndHighlight()
  :wincmd p
endfunction

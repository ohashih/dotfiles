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

" undoFileの永続化
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

"" 後方に貼り付け
command! FzfPaste :call s:FzfPaste()
function! s:FzfPaste()
  let reg = execute(":reg")
  let regs = split(reg, "\n")
  call remove(regs, 0)
  call fzf#run({'source': regs, 'sink': funcref('s:write'), 'down': '25%'})
endfunction

func! s:write(s) abort
  execute ':norm ' . strcharpart(a:s,5,2) . 'p'
endfunc

"" 前方に貼り付け
command! FzfShiftPaste :call s:FzfShiftPaste()
function! s:FzfShiftPaste()
  let reg = execute(":reg")
  let regs = split(reg, "\n")
  call remove(regs, 0)
  call fzf#run({'source': regs, 'sink': funcref('s:write'), 'down': '25%'})
endfunction

func! s:write(s) abort
  execute ':norm ' . strcharpart(a:s,5,2) . 'P'
endfunc

:nnoremap <Leader>p :FzfPaste<CR>
:nnoremap <Leader>o :FzfShiftPaste<CR>

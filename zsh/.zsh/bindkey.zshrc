bindkey -e

# 履歴検索（入力中の文字列で履歴を検索）
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" fzf-history-widget

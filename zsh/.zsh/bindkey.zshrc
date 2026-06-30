bindkey -e

# 履歴検索（入力中の文字列で履歴を検索）
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# zsh-history-substring-search (sheldon 管理) を ↑/↓ に割り当て
# prezto の history-substring-search モジュールの代替
if (( $+widgets[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
fi

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" fzf-history-widget
bindkey "^L" clear-screen

# Shift+Tab で補完候補を逆順に選択する
bindkey "^[[Z" reverse-menu-complete

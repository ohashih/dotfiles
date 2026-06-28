# mise
eval "$(/opt/homebrew/bin/mise activate zsh)"

# libexec
eval "$(/usr/libexec/path_helper)"

# zoxide (スマート cd: `z <dir>` でジャンプ、`zi` で fzf 選択)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

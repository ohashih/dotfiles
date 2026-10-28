# Homebrew (Apple Silicon)。.zshrc の sheldon 判定より前に PATH を通す。
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Created by `pipx` on 2026-03-11 01:29:57
export PATH="$PATH:$HOME/.local/bin"

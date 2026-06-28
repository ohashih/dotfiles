#zmodload zsh/zprof
# https://chocoby.com/blog/2021/05/05/speed-up-zsh-startup-time/

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# sheldon (zplug から移行。プラグインは ~/.config/sheldon/plugins.toml で管理)
# 初回/更新時は `sheldon lock --update` を実行。
if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
fi

# custom source_file function
function source_file {
  if [ $# -lt 1 ]; then
    echo "ERROR!!! source_file is called w/o an argument"
    return
  fi
  arg="$1"
  shift
  if [ -r "$arg" ]; then
    source "$arg"
  fi
}

# Activate Program
source_file ~/.zsh/init.zshrc

# Setting zsh color
source_file ~/.zsh/style.zshrc

# Setting path
source_file ~/.zsh/path.zshrc

# Setting env
source_file ~/.zsh/env.zshrc

# Setting alias
source_file ~/.zsh/alias.zshrc

# Setting bindkey
source_file ~/.zsh/bindkey.zshrc

# Setting zsh options
source_file ~/.zsh/option.zshrc

# Setting zsh options
source_file ~/.zsh/fzf.zshrc

# Setting complete
source_file ~/.zsh/complete.zsh

# Setting zsh cdpath

source_file ~/.zsh/cdpath.zshrc

# Setting zsh function

source_file ~/.zsh/function.zshrc

# Setting secret
source_file ~/.zsh/secret.zshrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# p10k instant prompt と clear-screen の相性問題を回避するカスタムウィジェット
function _clear_screen_widget() {
  clear
  zle reset-prompt
}
zle -N _clear_screen_widget
bindkey "^L" _clear_screen_widget

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kurage/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# tmux 自動起動 (prezto tmux:auto-start モジュールの代替)
# 対話シェルかつ tmux/エディタ外のときに main セッションへ attach、無ければ新規作成。
if [[ -o interactive && -z "$TMUX" && -z "$INSIDE_EMACS" && -z "$VIMRUNTIME" ]] && command -v tmux >/dev/null 2>&1; then
  tmux attach -t main 2>/dev/null || tmux new -s main
fi

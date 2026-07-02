# pane_title (tmux #T) を素の zsh ではホスト名でなくカレントディレクトリ名にする。
# tmux 配下では OSC 2 をそのまま pane title として解釈する (nvim 等と同じ仕組み)。
_set_pane_title() {
  print -Pn "\e]2;%1~\a"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _set_pane_title
add-zsh-hook preexec _set_pane_title

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function source_file {
  if [ $# -lt 1 ];then
    echo "ERROR!!! source_file is called w/o an argument"
    return
  fi
  arg="$1"
  shift
  if [ -r "$arg" ]; then
    source "$arg"
  fi
}

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

autoload -Uz compinit
compinit

# Setting zsh color
source_file ~/.zsh/style.zshrc

# Setting path
source_file ~/.zsh/path.zshrc

# Setting env
source_file ~/.zsh/env.zsrhrc

# Setting alias
source_file ~/.zsh/alias.zshrc

# Setting bindkey
source_file ~/.zsh/bindkey.zshrc

# Setting zsh options
source_file ~/.zsh/option.zshrc

# Setting zsh options
source_file ~/.zsh/fzf.zshrc

# Setting zsh cdpath

source_file ~/.zsh/cdpath.zshrc

# Setting fly.io complication

source_file ~/.zsh/flyio.zshrc

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# source /usr/local/bin/aws_zsh_completer.sh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

source /Users/kurage/.config/broot/launcher/bash/br

# Created by `pipx` on 2022-02-01 07:57:20
export PATH="$PATH:/Users/kurage/.local/bin"
export PATH="/Users/kurage/git/git-fuzzy/bin:$PATH"

. ~/.asdf/plugins/java/set-java-home.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

complete -o nospace -C /Users/kurage/.asdf/installs/terraform/1.3.3/bin/terraform terraform

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER="," # default: '**'

# stripe compoletion
fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i

#autoload -U compinit; compinit

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

function imgcat_tmux() {
    # @See: https://qastack.jp/unix/88296/get-vertical-cursor-position
    get_cursor_position() {
        old_settings=$(stty -g) || exit
        stty -icanon -echo min 0 time 3 || exit
        printf '\033[6n'
        pos=$(dd count=1 2> /dev/null)
        pos=${pos%R*}
        pos=${pos##*\[}
        x=${pos##*;} y=${pos%%;*}
        stty "$old_settings"
    }
    command imgcat "$1"
    [ $? -ne 0 ] && return
    [ ! "$TMUX" ] && return
    get_cursor_position
    # 2行分画像が残ってしまうためtputで再描画判定させて消す
    read && tput cup `expr $y - 2` 0
}

# don't run the completion function when being source-ed or eval-ed
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

source_file ~/.mdbook.zsh

# zmodload zsh/zprof
# https://chocoby.com/blog/2021/05/05/speed-up-zsh-startup-time/

# Powerlevel10k のShell起動のcache
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


# custom source_file function
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

# Setting complete
source_file ~/.zsh/complete.zsh

# Setting zsh cdpath
source_file ~/.zsh/cdpath.zshrc

# Setting Andy Photobook AI
# source_file ~/.zsh/apb.zshrc

# Setting secret
source_file ~/.zsh/secret.zshrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

## mise
eval "$(/usr/local/bin/mise activate zsh)"

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

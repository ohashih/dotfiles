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

source ~/.zplug/init.zsh

autoload -U compinit
compinit -u

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
source_file ~/.zsh/option.zsrhrc

# Setting zsh options
source_file ~/.zsh/fzf.zshrc

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

source /usr/local/bin/aws_zsh_completer.sh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

source /Users/kurage/.config/broot/launcher/bash/br

# Created by `pipx` on 2022-02-01 07:57:20
export PATH="$PATH:/Users/kurage/.local/bin"

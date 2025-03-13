fpath=(~/.zsh/complete $fpath)

# source /usr/local/bin/aws_zsh_completer.sh
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
compinit -u

autoload -U ~/.zsh/complete/*

# terraform
complete -o nospace -C ~/.asdf/shims/terraform terraform

# aws compoletion
complete -C 'aws_completer' aws

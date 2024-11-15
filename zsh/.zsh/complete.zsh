# source /usr/local/bin/aws_zsh_completer.sh
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
compinit

# terraform
complete -o nospace -C /usr/local/bin/terraform terraform

# stripe compoletion
fpath=(~/.stripe $fpath)

# aws compoletion
complete -C '/usr/local/bin/aws_completer' aws

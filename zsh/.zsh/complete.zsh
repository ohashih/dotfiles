fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=(~/.zsh/complete $fpath)

# source /usr/local/bin/aws_zsh_completer.sh
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
compinit -u

autoload -U ~/.zsh/complete/*

# terraform
complete -o nospace -C "terraform" terraform

# tofu
complete -o nospace -C "tofu" tofu

# aws compoletion
complete -o nospace -C "aws_completer" aws

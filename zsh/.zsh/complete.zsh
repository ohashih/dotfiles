autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# terraform
complete -o nospace -C 'terraform' terraform

# aws compoletion
complete -C 'aws_completer' aws

# custom completions
fpath=(~/.zsh/completions $fpath)

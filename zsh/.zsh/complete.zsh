autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# gh
eval "$(gh completion -s zsh)"

# terraform
complete -o nospace -C 'terraform' terraform

# aws compoletion
complete -C 'aws_completer' aws

# custom
fpath=(~/.zsh/completions $fpath)

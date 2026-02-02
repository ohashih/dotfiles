autoload bashcompinit && bashcompinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# gh
eval "$(gh completion -s zsh)"

# terraform
complete -o nospace -C 'terraform' terraform

# aws compoletion
complete -C 'aws_completer' aws

# custom
fpath=(~/.zsh/completions $fpath)

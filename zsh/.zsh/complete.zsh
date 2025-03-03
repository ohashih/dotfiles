autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# terraform
#complete -o nospace -C ~/.asdf/shims/terraform terraform

# aws compoletion
complete -C '~/.local/share/mise/installs/awscli/2.23.2/aws-cli.pkg/Payload/aws-cli/aws_completer' aws

# custom completions
fpath=(~/.zsh/completions $fpath)

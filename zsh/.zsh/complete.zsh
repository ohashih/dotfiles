# custom (must be before compinit)
fpath=(~/.zsh/completions /opt/homebrew/share/zsh/site-functions $fpath)

autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

autoload -Uz bashcompinit && bashcompinit

# gh
eval "$(gh completion -s zsh)"

# terraform
complete -o nospace -C 'terraform' terraform

# aws completion
complete -C 'aws_completer' aws

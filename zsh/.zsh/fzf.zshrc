[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER="," # default: '**'

export FZF_DEFAULT_OPTS='
  --height 100%
  --reverse
  --border
  --inline-info
  --color=fg:#c5cdd9,bg:#262729,hl:#6cb6eb
  --color=fg+:#c5cdd9,bg+:#262729,hl+:#5dbbc1
  --color=info:#88909f,prompt:#ec7279,pointer:#d38aea
  --color=marker:#a0c980,spinner:#ec7279,header:#5dbbc1
'
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
FZF_DEFAULT_COMMAND="rg --column --line-number --no-heading --color=always --smart-case"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'eza -T --git-ignore {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

## fvi open file for vim
fvi() {
  local file
  file=$(find . | fzf)
  vi "$file"
}

## fvir search word
fvir() {
  local file
  file=$(rg $1 | fzf | cut -d ":" -f 1)
  vim $file
}

function select-git-switch() {
  target_br=$(
    git branch -a |
      fzf --exit-0 --layout=reverse --info=hidden --no-multi --preview-window="right,65%" --prompt="CHECKOUT BRANCH > " --preview='f() { echo $1 | tr -d " *" | xargs git lg --color=always }; f {}' |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    echo "git switch $target_br"
    git switch $target_br
    zle accept-line
  fi
}
zle -N select-git-switch
bindkey "^v" select-git-switch

function select-git-directory() {
  cd $(ghq list | fzf)
}
zle -N select-git-directory
bindkey "^w" select-git-directory

## fgc git checkout
#fgc() {
#  local branches branch
#  branches=$(git branch -vv) &&
#  branch=$(echo "$branches" | fzf +m) &&
#  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
#}
#
#zle -N fgc
#bindkey '^v' fgc

## fgcl
fgcl() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//") | xargs git checkout
}

# fcb google bookmark
fcb() {
  bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks
  jq_script='
     def ancestors: while(. | length >= 2; del(.[-1,-2]));
     . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'
 jq -r "$jq_script" < "$bookmarks_path" \
     | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
     | fzf --ansi \
     | cut -d$'\t' -f2 \
     | xargs open
}

# fzf-cdr
alias cdd='fzf-cdr'
function fzf-cdr() {
    target_dir=`cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf`
    target_dir=`echo ${target_dir/\~/$HOME}`
    if [ -n "$target_dir" ]; then
        cd $target_dir
    fi
}

autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*'      recent-dirs-max 500
  zstyle ':chpwd:*'      recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

alias co='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

gd() {
  preview="git diff develop --color=always -- {-1}"
  git diff develop --name-only | fzf -m --ansi --preview $preview
}

function sshsp() {
  local host=$(grep -E "^Host " ~/.ssh/config | sed -e 's/Host[ ]*//g' | fzf)
  if [ -n "$host" ]; then
    ssh $host
  fi
}

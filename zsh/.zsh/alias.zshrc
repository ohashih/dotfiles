# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# diff settings
alias diff='colordiff'
alias diffy='diff -y --suppress-common-lines'

# ls settings
alias ls="ls -G"
alias ll="ls -l"

# standard command settings
alias vi='nvim'
alias cat='bat'

# js-beautify setting
alias js-beautify="js-beautify \
    --replace \
    --comma-first \
    --end-with-newline \
    --good-stuff \
    --indent-size 2 \
    --jslint-happy"

# alias git
alias gaa="git add ."
alias glog="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by\"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"
alias gc-b="git checkout -b"
alias gp="git push"
alias gsp="git push --set-upstream origin"
alias gbf="git branch | grep feature | xargs git branch -d"

# path utility
alias bin="~/bin"
alias md="~/md"
alias aibs="~/git/a-ibs"
alias vineo="~/.config/nvim"
alias home="~/Desktop"
alias kurage="~/git/kurage"

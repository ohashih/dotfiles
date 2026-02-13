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

# standard command settings
alias vim='nvim'
alias vi='nvim'
alias cat='bat --theme="TwoDark" --style="header,changes" --map-syntax ".ignore:Git Ignore"'

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
alias mdp="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/md/private-memo/"
alias md="cd ~/md"
alias aibs="~/git/a-ibs"
alias aucnet="~/git/aucnet"
alias vineo="~/.config/nvim"
alias home="~/Desktop"
alias kurage="~/git/kurage"
alias pwdc="pwd | pbcopy"
alias gui="lazygit"
alias vitask="vi ~/private/task.md"
alias dynamo="node ~/dynamo/dynamo.js"
alias gdiff="git-split-diffs --color"
alias imgcat="imgcat_tmux"
alias lzd="lazydocker"

# utility
alias restart-audio="sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"
alias calen="icalBuddy -f -sd eventsToday+10"
alias compression="tar -zcvf"
alias uncompression="tar -zxvf"

# exa
alias ls="eza"
alias ll="eza -ahl --git --icons=always"
alias tree="eza -T --git-ignore"

# docker
alias docker-purge='docker stop $(docker ps -q) && docker rm $(docker ps -aq)'

# tmuxinator

alias mux='tmuxinator'

# AWS
# measure plugin weight
# alias timeNvim="echo \"scale=3; $(nvim --startuptime /tmp/stime_mine.log -c 'quit' > /dev/null && tail -n 1 /tmp/stime_mine.log | cut -d ' ' -f1) / $(vi -u DEFAULTS --startuptime /tmp/stime_def.log -c 'quit' > /dev/null && tail -n 1 /tmp/stime_def.log | cut -d ' ' -f1)\" | bc | xargs echo {}x slower your Vim than the default."

# private

alias memo="vi ~/admin/memo.md"

# AWS Git checkout

alias aws-main="pushd ~/.aws && git checkout main && popd"
alias aws-flex="pushd ~/.aws && git checkout flex && popd"
alias aws-kurage="pushd ~/.aws && git checkout kurage && popd"
alias aws-aba="pushd ~/.aws && git checkout aba && popd"

# deepl
# https://github.com/kojix2/deepl-cli
alias deepl="deepl -t ja"

# kitty
alias icat="kitty +kitten icat"

# pass
alias rpass="cat ~/admin/password.md"
alias wpass="vi ~/admin/password.md"

# Default
export PATH="$PATH:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"


# The next line enables shell command completion for gcloud.
export PATH="$PATH:/usr/local/opt/libxml2/bin"
export PATH="$PATH:/usr/local/opt/libxslt/bin"
export PATH="$PATH:/usr/local/opt/libiconv/bin"
export PATH="$PATH:/usr/local/opt/libxslt/bin"
export PATH="$PATH:/usr/local/opt/libxml2/bin"

SSH_KEY_PATH="~/.ssh/id_rsa"

# yarn
export PATH="$PATH:/Users/kurage/.config/yarn/global/node_modules/.bin"

# icu4c
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# JAVA
#export JAVA_HOME=`/usr/libexec/java_home -v 15`

# libexec
eval "$(/usr/libexec/path_helper)"

eval "$(gh completion -s zsh)"

# ITN
export PATH="$PATH:$HOME/bin-itn"

# postgres installer
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# fuzzy
export PATH="~/git/git-fuzzy/bin:$PATH"

# homebrew package path
#export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

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
export JAVA_HOME=`/usr/libexec/java_home -v 15`

# libexec
eval "$(/usr/libexec/path_helper)"

# asdf
. /usr/local/opt/asdf/libexec/asdf.sh
#. $(brew --prefix asdf)/asdf.sh
export PATH="$HOME/.asdf/bin:$PATH"
eval "$(asdf exec direnv hook bash)"
eval "$(gh completion -s zsh)"

# Rust
source $HOME/.cargo/env

# ITN
export PATH="$PATH:$HOME/bin-itn"

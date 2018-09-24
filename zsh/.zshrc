# Paths
export JAVA_HOME="$(/usr/libexec/java_home)"
export GO_HOME=/usr/local/go/bin
export GOPATH=$HOME/dev
export CARGO_HOME=$HOME/.cargo
export ANDROID_HOME=/Users/jaredramirez/Library/Android/sdk
export ANDROID_SDK_ROOT=/Users/jaredramirez/Library/Android/sdk
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=~/Library/Python/2.7/bin:$PATH
export PATH=$GOPATH/bin:$GO_HOME:$PATH
export PATH=$CARGO_HOME/bin:$PATH
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/apps:$PATH"
export PATH="$HOME/bin:$PATH"
export NVM_DIR="$HOME/.nvm"

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Path to custom helpers
source ~/scripts/helpers.sh

# Alias git to hub
eval "$(hub alias -s)"

# Theme & theme related attributes
ZSH_THEME="spaceship"
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_CHAR_SYMBOL="λ "
SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_SHOW=true
SPACESHIP_PACKAGE_SHOW=false

# Plugins, use wisely as to many will slow down shell startup
plugins=(git yarn brew vi-mode history-substring-search)

# Reload for plugins & theme
source $ZSH/oh-my-zsh.sh

# Search History
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# Set language
export LANG=en_US.UTF-8

# Set Editor
export EDITOR='nvim'

# Aliases
alias icloud='~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias zshreload='source ~/.zshrc'
alias trash="rmtrash"

# OPAM configuration -- Probably should remove
. /Users/jaredramirez/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

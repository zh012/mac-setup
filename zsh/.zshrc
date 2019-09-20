# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jerryzhang/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="myamuse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(history git docker docker-compose)
plugins=(history git docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# anaconda
PATH_WITHOUT_CONDA="/usr/local/sbin:$PATH"
PATH_WITH_CONDA="/usr/local/anaconda3/bin:$PATH"
export PATH=$PATH_WITHOUT_CONDA

function condaenv() {
    if [[ "$1" == "off" ]]; then
        export PATH=$PATH_WITHOUT_CONDA
    else
        export PATH=$PATH_WITH_CONDA
    fi
}
function co() {
    condaenv on; source activate $1
}

function sshconfig() {
    if [[ -f ~/.ssh/config.$1 ]]; then
        cd ~/.ssh
        ln -nsf ./config.$1 config
        cd -
    else
        echo "config $1 does not exist"
    fi
}

# switch aws credentials
function awsenv() {
    if [[ -f ~/.aws/credentials.$1 ]]; then
        cd ~/.aws
        rm credentials || true
        ln -nsf ./credentials.$1 credentials
        cd -
    else
        echo "env $1 does not exist"
    fi
}

alias curl-trace='curl -w "@~/.curl-format" -o /dev/null -s'

eval "$(rbenv init -)"
alias rbenv-doctor='curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash'

alias gconf-side='git config user.name zh012 && git config user.email hui.zhang.jerry@gmail.com'
alias gconf-work='git config user.name "Jerry Zhang"  && git config user.email jerry.zhang@paytm.com'


if [ -f /Users/jerryzhang/.kubectlsrc ]; then 
    source ~/.kubectlsrc
fi

###-tns-completion-start-###
if [ -f /Users/jerryzhang/.tnsrc ]; then 
    source /Users/jerryzhang/.tnsrc 
fi
###-tns-completion-end-###

### brew cask install adoptopenjdk8
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

### brew cask install android-sdk
export ANDROID_HOME=/usr/local/share/android-sdk
function emu { cd $(dirname $(readlink `which  emulator`)) && ./emulator "$@"; cd -; }

### https://flutter.dev/docs/get-started/install/macos
export PATH="$PATH:/Users/jerryzhang/tools/flutter/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jerryzhang/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jerryzhang/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jerryzhang/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jerryzhang/tools/google-cloud-sdk/completion.zsh.inc'; fi

# for terraform using the aws config file
export AWS_SDK_LOAD_CONFIG=1
alias tf=terraform

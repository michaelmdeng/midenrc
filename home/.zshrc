# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="miden"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  autopep8
  bgnotify
  dotenv
  fzf
  git
  nvm
  rvm
  safe-paste
  sbt
  scala
  themes
  vi-mode
  virtualenv
  virtualenvwrapper
)

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

# bash completions
autoload -U +X bashcompinit && bashcompinit

# shared bashrc/zshrc commands
source "$HOME/.sharedshrc"

setopt auto_cd

# zsh completions
[ -f "$HOME/.completion/tmuxinator.zsh" ] && source "$HOME/.completion/tmuxinator.zsh"
[ -f "$HOME/.completion/.fzf.zsh" ] && source "$HOME/.completion/.fzf.zsh"
[ -f "$HOME/.completion/gh.zsh" ] && source "$HOME/.completion/gh.zsh"
[ -f "${HOME}/.completion/.iterm2_shell_integration.zsh" ] && source "${HOME}/.completion/.iterm2_shell_integration.zsh"

complete -o nospace -C /usr/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/applications/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/applications/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/applications/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/applications/google-cloud-sdk/completion.zsh.inc"; fi

# zsh functions
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

###########################################
# START Square
###########################################

# Allow more open files than the OSX default of 256
ulimit -n 4096

# completion
autoload -U compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

typeset -U path
# Check if a path exists
function append_to_path {
  if [ -d "$1" ]; then
    path+=$1
  fi
}

function prepend_to_path {
  if [ -d "$1" ]; then
    path=($1 $path)
  fi
}

prepend_to_path /usr/local/bin
prepend_to_path /usr/local/sbin
prepend_to_path /usr/local/share/npm/bin
prepend_to_path $HOME/bin
append_to_path /usr/local/mysql/bin
append_to_path /opt/nginx/sbin
append_to_path /opt/local/bin
append_to_path /opt/local/sbin

source ~/.zsh/completion.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/rake_completion.zsh

# source the scripts in square/profile.d/
source ~/Development/config_files/square/profile

###########################################
# END Square
###########################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mdeng/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mdeng/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mdeng/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mdeng/google-cloud-sdk/completion.zsh.inc'; fi

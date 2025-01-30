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
  dotenv
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

__pip() {{
	eval $(pip completion --zsh)
        }}
if [[ $zsh_eval_context[-1] == loadautofunc ]]; then
    # autoload from fpath, call function directly
    __pip "$@"
else
    # eval/source/. command, register function for later
    compdef __pip -P pip
    compdef __pip -P pip3
fi

if check_cmd_exists "k9s"; then
    eval $(k9s completion zsh)
fi

if check_cmd_exists "gh"; then
    eval "$(gh completion -s zsh)"
fi

if check_cmd_exists "docker"; then
    eval "$(docker completion zsh)"
fi

if check_cmd_exists "fzf"; then
    source <(fzf --zsh)
fi

if check_cmd_exists "mise"; then
    eval "$(mise activate zsh)"
fi

complete -o nospace -C /usr/bin/terraform terraform

# zsh functions
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mdeng/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mdeng/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mdeng/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mdeng/Applications/google-cloud-sdk/completion.zsh.inc'; fi

# Airbnb

[ -f "$HOME/.completion/aws-creds.zsh" ] && source "$HOME/.completion/aws-creds.zsh"

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/um/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/coursier/bin"
export PATH="/opt/homebrew/opt/libpq:$PATH"
export PATH="$PATH:$HOME/.conscript/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/Source/mdcli/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="$HOME/.pyenv/bin:$PATH"
if type "pyenv" > /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv virtualenvwrapper
else
    echo "warning: pyenv not found. Is it installed?"
fi

export PATH="$HOME/.jenv/bin:$PATH"
if type "jenv" > /dev/null; then
    eval "$(jenv init -)"
else
    echo "warning: jenv not found. Is it installed?"
fi

export PATH="$PATH:/usr/local/go/bin"

export EDITOR='nvim'
export PROJECT_HOME=$HOME/Documents
export TERM=screen-256color
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME=$HOME/.virtualenvs

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Opt out of homebrew analytics collection
export HOMEBREW_NO_ANALYTICS=1

if [ -d "/opt/homebrew/bin/brew shellenv" ] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "$HOME/.cargo/env" ] ; then
    . "$HOME/.cargo/env"
fi

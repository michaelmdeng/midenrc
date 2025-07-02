# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/.yarn/bin" ] ; then
    export PATH="$PATH:$HOME/.yarn/bin"
fi
if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ] ; then
    export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
fi
if [ -d "/opt/homebrew/opt/libpq" ] ; then
    export PATH="$PATH:/opt/homebrew/opt/libpq"
fi
if [ -d "$HOME/Source/mdcli/bin" ] ; then
    export PATH="$PATH:$HOME/Source/mdcli/bin"
fi

export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$HOME/.pyenv/bin" ] ; then
    export PATH="$PATH:$HOME/.pyenv/bin"
fi

if [ -d "/usr/local/go/bin" ] ; then
    export PATH="$PATH:/usr/local/go/bin"
fi
if [ -d "$HOME/go/bin" ] ; then
    export PATH="$PATH:$HOME/go/bin"
fi

if [ -d "$HOME/Source/lua-language-server" ] ; then
    PATH="$PATH:$HOME/Source/lua-language-server/bin"
fi

export EDITOR='nvim'
export PROJECT_HOME=$HOME/Source
export TERM=screen-256color
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export WORKON_HOME=$HOME/.virtualenvs

# Opt out of homebrew analytics collection
export HOMEBREW_NO_ANALYTICS=1

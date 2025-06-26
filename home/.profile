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

if [ -d "$HOME/Source/mdcli/bin" ] ; then
    export PATH="$PATH:$HOME/Source/mdcli/bin"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

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

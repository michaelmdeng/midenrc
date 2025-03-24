# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mdeng/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && {
  [[ -f "$HOME/.fzf/shell/completion.bash" ]] && source "$HOME/.fzf/shell/completion.bash" 2>/dev/null
  command -v brew >/dev/null && [[ -f "$(brew --prefix fzf)/shell/completion.bash" ]] && source "$(brew --prefix fzf)/shell/completion.bash" 2>/dev/null
}

# Key bindings
# ------------
{
  [[ -f "$HOME/.fzf/shell/key-bindings.bash" ]] && source "$HOME/.fzf/shell/key-bindings.bash" 2>/dev/null
  command -v brew >/dev/null && [[ -f "$(brew --prefix fzf)/shell/key-bindings.bash" ]] && source "$(brew --prefix fzf)/shell/key-bindings.bash" 2>/dev/null
}

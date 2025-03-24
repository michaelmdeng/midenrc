# Setup fzf
# ---------
if [[ ! "$PATH" == */home/michaeldeng/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && {
  [[ -f "$HOME/.fzf/shell/completion.zsh" ]] && source "$HOME/.fzf/shell/completion.zsh" 2>/dev/null
  command -v brew >/dev/null && [[ -f "$(brew --prefix fzf)/shell/completion.zsh" ]] && source "$(brew --prefix fzf)/shell/completion.zsh" 2>/dev/null
}

# Key bindings
# ------------
{
  [[ -f "$HOME/.fzf/shell/key-bindings.zsh" ]] && source "$HOME/.fzf/shell/key-bindings.zsh" 2>/dev/null
  command -v brew >/dev/null && [[ -f "$(brew --prefix fzf)/shell/key-bindings.zsh" ]] && source "$(brew --prefix fzf)/shell/key-bindings.zsh" 2>/dev/null
}

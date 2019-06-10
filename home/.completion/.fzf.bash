# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mdeng/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/mdeng/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mdeng/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mdeng/.fzf/shell/key-bindings.bash"

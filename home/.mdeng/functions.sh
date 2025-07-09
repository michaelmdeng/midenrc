# Custom functions

mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# fzf command history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]*\** *//')
}

# fzf cd dir
fcd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fzf file content
ff() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi

  if [ "$#" -eq 1 ]; then
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
    return
  else
      rg --files-with-matches --no-messages "$1" "$2" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
  fi
}

# fkill - kill processes - list only the ones you can kill.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

check_cmd_exists() {
  if command -v "$1" &> /dev/null; then
    return 0
  else
    return 1
  fi
}

ubuntu_update() {
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
  sudo apt-get autoclean -y
}

llmedit() {
  local tmp=$(mktemp)
  "${EDITOR:-nvim}" "$tmp" || return
  llm "$@" "$(cat "$tmp")"
  local ec=$?
  if [ $ec -ne 0 ]; then
    echo "llm failed with exit code: $ec. Prompt saved at: $tmp"
  else
    rm -f "$tmp"
  fi
}

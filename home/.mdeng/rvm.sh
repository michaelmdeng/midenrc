function setup_rvm() {
  local binaries=(erb irb bundle ruby rdoc)

  for binary in $binaries; do
    source /dev/stdin <<EOF
function ${binary}() {
  for t in ${binaries}; do
    unset -f "\$t";
  done

  if [[ !(-v "\$rvm_loaded") || "\$rvm_loaded" -eq false ]]; then
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm";
    rvm_loaded=true;
  fi

  ${binary} "\$@";
}
EOF
  done

  unset -f "setup_rvm"
}

setup_rvm

function setup_nvm() {
  local binaries=(nvm node npm pnpm yarn tern eslint)

  for binary in $binaries; do
    source /dev/stdin <<EOF
function ${binary}() {
  for t in ${binaries}; do
    unset -f "\$t";
  done

  if [[ !(-v "\$nvm_loaded") || "\$nvm_loaded" -eq false ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm_loaded=true
  fi

  $binary "\$@";
}
EOF
  done

  unset -f "setup_nvm"
}

setup_nvm

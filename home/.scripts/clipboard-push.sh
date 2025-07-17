#!/bin/bash
set -euo pipefail
TEMPFILE=$(mktemp)
trap 'rm -f "${TEMPFILE}"' EXIT

# Save stdin to file
cat > "$TEMPFILE"

# Push to tmux
tmux load-buffer "$TEMPFILE"

# Push to system clipboard
pbcopy < "$TEMPFILE"

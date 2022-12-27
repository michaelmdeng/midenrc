#!/bin/bash
# Find a filename to use as a temp file
TEMPFILE="`tempfile 2>/dev/null`"
if [ $? -ne 0 ]; then
	TEMPFILE="/tmp/_clip_temp_yssh$USER"
fi
# Save stdin to file
cat > "$TEMPFILE"

# Push to tmux
tmux load-buffer "$TEMPFILE"

# Push to system clipboard
cat "$TEMPFILE" | pbcopy

# Remove file
rm -f "$TEMPFILE"

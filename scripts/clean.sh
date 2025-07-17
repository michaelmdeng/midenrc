#!/usr/bin/env bash

# macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! command -v grealpath &> /dev/null; then
    echo "Error: 'grealpath' not found. Please install coreutils:" >&2
    echo "  brew install coreutils" >&2
    exit 1
  fi
  if ! command -v gfind &> /dev/null; then
    echo "Error: 'gfind' not found. Please install findutils:" >&2
    echo "  brew install findutils" >&2
    exit 1
  fi
  REALPATH_CMD="grealpath"
  FIND_CMD="gfind"
else
  REALPATH_CMD="realpath"
  FIND_CMD="find"
fi

DRY_RUN=0
INTERACTIVE=0

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run|-n)
      DRY_RUN=1
      shift
      ;;
    --interactive)
      INTERACTIVE=1
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

if [ "$DRY_RUN" -eq 1 ] && [ "$INTERACTIVE" -eq 1 ]; then
  echo "Error: --dry-run and --interactive cannot be used together." >&2
  exit 1
fi

shopt -s dotglob

IFS=$'\n'
for dir in "./home"/*/; do
  [ -d "$dir" ] || continue
  resolved_dir=$($REALPATH_CMD "$dir")

  home_path="$HOME/$(basename "$dir")"

  for symlink in $($FIND_CMD "$home_path" -xtype l); do
    target=$(readlink "$symlink")
    resolved_target=$($REALPATH_CMD -m "$(dirname "$symlink")/$target")
    if [[ "$resolved_target" == "$resolved_dir"/* ]]; then
      if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would delete: $symlink" >&2
      else
        if [ "$INTERACTIVE" -eq 1 ]; then
          rm -i "$symlink"
        else
	  echo "Deleting: $symlink" >&2
          rm "$symlink"
        fi
      fi
    fi
  done
done

unset IFS
shopt -u dotglob
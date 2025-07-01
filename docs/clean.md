I want to develop a script (`./scripts/clean.sh`) that will clean broken/deleted symlinks from my homeshick
castle.

For each top-level directory under `./home/` in this repo:

1. Traverse the corresponding directory recursively in my own home directory
2. Find all symlinks for this homeshick castle that are broken or point to non-existent
   files
3. Remove them (or during dry run), print the files that would be removed.

For each top-level file under `./home/` in this repo

1. Check if the corresponding file in the user's home directory contains a broke symlink
   to the current homeshick castle
2. If so, remove the file, or during dry run, print the file that would be removed

Script must:

* Be a bash script
* Follow standard bash conventions and best practices
* Work both on macOS and Linux
    * Can leverage gnu coreutils on Mac installed with homebrew, but must account for the
      different binary name
* Avoid recursing all of the user's home directory, only the dirs specified in the castle
* Avoid deleting symlinks to other homeshick castles, whether or not they are broken

#!/bin/bash
SCRIPT=$(realpath $0)
CWD=$(dirname $SCRIPT)
echo $CWD

for directory in $CWD/.config/*/; do
  echo Syncing $(basename $directory) configuration...
  cp -Rsv $directory $HOME/.config 2>/dev/null
  echo Synced $(basename $directory) successfully!
  echo
done

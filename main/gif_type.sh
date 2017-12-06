#!/bin/bash
dir=$(pwd)
SELECTION=$(sed '6q;d' "$dir/gif_settings.txt")
SELECTION=${SELECTION:7}
if [[ $SELECTION -eq 1 ]]; then
  echo "freeze"
elif [[ $SELECTION -eq 0 ]]; then
  echo "dinamic"
fi

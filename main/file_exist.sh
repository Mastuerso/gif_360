#!/bin/bash
w_dir=$1
type=$2
#echo "$w_dir/*.$type"  1>&2
if [ ! -f "$w_dir/"*".$type" ]; then
    PRESENT=$((0))
    echo "$PRESENT"
  else
    PRESENT=$((1))
    echo "$PRESENT"
fi


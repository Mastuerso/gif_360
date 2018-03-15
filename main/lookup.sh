#!/bin/bash
subject=$1
file=$2
index=${3:-$((0))}
dir=$(pwd)
values=$(cat $file | grep $subject)
#echo "$values" 1>&2
lineCount=$(echo "$values" | wc -l)
#echo "$lineCount" 1>&2
if [[ $lineCount -gt $((1)) ]]; then
    readarray -t value < <(echo "$values")
    value=$(echo "${value[$index]}" | sed 's/.*=//')
    echo "${value}" | sed -e 's/^[ \t]*//'
    #echo "${value[$index]//[!0-9]}"
    else
    value=$(echo "${values}" | sed 's/.*=//')
    echo "${value}" | sed -e 's/^[ \t]*//'
    #value=${values//[!0-9]}
    #echo "$value"
fi

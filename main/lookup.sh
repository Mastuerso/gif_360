#!/bin/bash
subject=$1
file=$2
index=${3:-$((0))}
dir=$(pwd)
values=$(cat $file | grep $subject)
lineCount=$(echo "$values" | wc -l)
#echo "$lineCount" 1>&2
if [[ $lineCount -gt $((1)) ]]; then
    readarray -t value < <(echo "$values")
    echo "${value[$index]//[!0-9]}"
    else
    value=${values//[!0-9]}
    echo "$value"
fi
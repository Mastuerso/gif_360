#!/bin/bash
dir=$1
file_ext=$2
expected=$3

COUNT=$((0))
loop=$((1))

while [ $loop -eq $((1)) ]; do
    file_list=$(ls -1 $dir/*.$file_ext)
    #echo "$file_list" 1>&2
    founded=$(echo "${file_list}" | wc -l)
    if [ $founded -eq $expected ]; then
        loop=$((0))
        echo "valid dir"
    else
        sleep 1s
		rest=$((expected - founded))
		echo "missing $rest" 1>&2
        COUNT=$((COUNT+1))
		#echo "count: $COUNT" 1>&2
        if [ $COUNT -eq $expected ]; then
		    loop=$((0))
            echo "invalid dir"	    
        fi
    fi
done
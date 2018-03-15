#!/bin/bash
dir=$(pwd)
minidir=${1:-${dir}}
#echo "${minidir}" 1>&2
recipients=$(bash "${dir}/lookup.sh" "mailto" "${minidir}/gif_settings.txt")
#echo "${recipients}" 1>&2
#processed=$(cut -d ',' -f 1 "${recipients}")
processed=(`echo $recipients | tr ',' ' '`)
#echo "${processed[2]}" 1>&2
members=${#processed[@]}
#echo "number or recipients: ${members}"
if [[ $members -gt $((1)) ]]; then
    count=$((0))
    #phpArray=""
    #base64
    #json to php
    for rec in ${processed[@]}; do
        count=$((count+1))
        #echo "${count}: ${rec}" 1>&2
        if [[ $count == $((1)) ]]; then
            phpArray="\"${rec}\", \""
        elif [[ $count == $members ]]; then
            phpArray="${phpArray}${rec}\""
        else
            phpArray="${phpArray}${rec}\", \""
        fi
            #echo "${phpArray}"
    done
    phpArray="array(${phpArray})"
    echo ${phpArray}
else
    phpArray="array(\"${recipients}\")"
    echo ${phpArray}
fi

#!/bin/bash
echo "=====CHECKING INTERNET CONNECTION====" 1>&2

flag=$((0))

while [[ $flag -eq $((0)) ]]; do
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        echo "IPv4 is up" 1>&2
        flag=$((1))
    else
        echo "IPv4 is down" 1>&2
        echo "No INTERNET" 1>&2
        sleep 10s
    fi
done


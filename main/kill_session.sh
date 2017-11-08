#!/bin/bash
sleep 2
echo "killing session"
screen -list > screen_session.txt
file="$(pwd)/screen_session.txt"
scr_ss=0
while IFS= read line
do    
    #echo -n "$cam_count :"
	#echo "$line"
    scr_ss=$((scr_ss + 1))
    if [ $scr_ss -eq $((2)) ]; then
        #echo -n "Screen session number: "
        #echo ${line:1:5}
        line=${line:1:5}
        screen -S $line -X kill
        echo "Screen is donzo"
        #line="--port="${line//[[:space:]]/}
        #echo $line
        #cam_port[$cam_count]=$line               
        #echo "${cam_ports[$cam_count]}"      
    fi    
done <"$file"
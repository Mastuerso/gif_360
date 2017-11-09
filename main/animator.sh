#!/bin/bash
echo "---ANIMATOR---"
#cd "/home/onikom/Documents/Gif_Creator/main/"
#echo $(pwd)
w_dir="$(pwd)"
file="$w_dir/image_list.txt"

img_count=$((0))
count=$((0))
gifname=$(date +"%e%b-%R")
echo $gifname >gif_name.txt
#echo "gif name: $gifname"
nu_delay=$((0))

ls "$(pwd)/images">"$(pwd)/image_list.txt"
echo <"$(pwd)/image_list.txt"

while IFS= read line
do    
    #echo -n "$cam_count :"
	#echo "$line"*.JPG
    img_count=$((img_count + 1))
    if [ $img_count -gt $((0)) ]; then
        echo -n "$img_count: "
        echo ${line}
        line=${line}
        #line="--port="${line//[[:space:]]/}
        #echo $line
        #cam_port[$cam_count]=$line               
        #echo "${cam_ports[$cam_count]}"      
    fi    
done <"$file"

gif_settings=(25,0,0,0,0) #(speed, loop, patrol-cycle, in-between)

if [ $img_count -gt $((0)) ]; then    
    echo "img counted: $img_count"
    #echo "Looking for Gif settings ..."
    file="$w_dir/gif_settings.txt"
    if [ ! -f $file ]; then
        echo "Settings not found!"
        echo "Using default settings"
    else        
        echo "Reading Gif settings"
        while IFS= read line
        do
            echo ${line}
            if [ $count -eq $((0)) ]; then
                #echo "delay"
                line=${line:6}
                nu_delay=$line
            elif [ $count -eq $((1)) ]; then
                #echo "loop"
                line=${line:5}
            elif [ $count -eq $((2)) ]; then
                #echo "patrol_cycle_gif"
                line=${line:17}
            elif [ $count -eq $((3)) ]; then
                #echo "in_between"$(pwd)
                line=${line:11}
            elif [ $count -eq $((4)) ]; then
                line=${line:8}                
                #echo "quality $line"
                #exit
            elif [ $count -eq $((9)) ]; then
                line=${line:10}
            elif [ $count -eq $((10)) ]; then
                line=${line:6}
            fi
            gif_settings[$count]=$line
            #echo "${gif_settings[$count]}"
            count=$(( count+1 ))
        done <"$file"
    fi    
    
    if [ ${gif_settings[$((4))]} -lt $((100)) ]; then        
        mogrify -resize "${gif_settings[$((4))]}%" "$(pwd)/images/*.JPG"
    fi
    
    if [ ${gif_settings[$((2))]} -eq $((0)) ]; then
        echo "patrol cycle not needed"
        if [ ${gif_settings[$((3))]} -eq $((0)) ]; then
            echo "in_betweens not requested"
            #convert "$(pwd)/images/*.JPG" -delay ${gif_settings[$((0))]} -loop ${gif_settings[$((1))]} "$w_dir/$gifname.gif"
            convert -delay ${gif_settings[$((0))]} "$(pwd)/images/*.JPG" -loop ${gif_settings[$((1))]} "$w_dir/$gifname.gif"
        fi
        if [ ${gif_settings[$((3))]} -eq $((1)) ]; then
            echo "in_betweens requested"
            gif_settings[$((0))]=$(expr $nu_delay / 2)            
            #convert "$(pwd)/images/*.JPG" -delay ${gif_settings[$((0))]} -loop ${gif_settings[$((1))]} -morph 1 "$w_dir/$gifname.gif"
            convert -delay ${gif_settings[$((0))]} "$(pwd)/images/*.JPG" -loop ${gif_settings[$((1))]} -morph 1 "$w_dir/$gifname.gif"
        fi
    elif [ ${gif_settings[$((2))]} -eq $((1)) ]; then 
        echo "patrol cycle needed"
        if [ ${gif_settings[$((3))]} -eq $((0)) ]; then
            echo "in_betweens not requested"
            #convert "$(pwd)/images/*.JPG" -delay ${gif_settings[$((0))]} -loop ${gif_settings[$((1))]} "$w_dir/$gifname.gif"
            convert -delay ${gif_settings[$((0))]} "$(pwd)/images/*.JPG" -loop ${gif_settings[$((1))]} "$w_dir/$gifname.gif"
            convert "$w_dir/$gifname.gif" -coalesce -duplicate 1,-2-1 -quiet -layers OptimizePlus -loop 0 "$w_dir/b$gifname.gif"
            rm "$w_dir/$gifname.gif"
            mv "$w_dir/b$gifname.gif" "$w_dir/$gifname.gif"
        fi
        if [ ${gif_settings[$((3))]} -eq $((1)) ]; then
            echo "in_betweens requested"
            gif_settings[$((0))]=$(expr $nu_delay / 2)            
            #echo "${gif_settings[((0))]}"
            #convert "$(pwd)/images/*.JPG" -delay ${gif_settings[$((0))]} -loop ${gif_settings[$((1))]} -morph 1 "$w_dir/$gifname.gif"
            convert -delay ${gif_settings[$((0))]} "$(pwd)/images/*.JPG" -loop ${gif_settings[$((1))]} -morph 1 "$w_dir/$gifname.gif"
            convert "$w_dir/$gifname.gif" -coalesce -duplicate 1,-2-1 -quiet -layers OptimizePlus -loop ${gif_settings[$((1))]} "$w_dir/b$gifname.gif"
            rm "$w_dir/$gifname.gif"
            mv "$w_dir/b$gifname.gif" "$w_dir/$gifname.gif"
        fi    
    fi
    if [ ${gif_settings[$((9))]} -eq $((1)) ]; then
        convert "$w_dir/$gifname.gif" -coalesce null: ${gif_settings[$((10))]} -gravity center -layers composite "$w_dir/b$gifname.gif"
        rm "$w_dir/$gifname.gif"
        mv "$w_dir/b$gifname.gif" "$w_dir/$gifname.gif"
    fi
    #mv "$w_dir/$gifname.gif" "/home/onikom/Pictures/$gifname.gif"
    echo "gif ready"
else
    echo "Where are the images?"
fi

file="$w_dir/results.txt"
box_ready=false
while [[ "$box_ready" == false ]]; do
    echo -n "o" >/dev/ttyACM0
    timeout 0.1 cat </dev/ttyACM0 | tee $file
    line=$(sed '3q;d' $file)
    if [[ "$line" == Ready* ]]; then
        box_ready=true
    else
        box_ready=false
    fi    
done
echo -e "Box Ready\n"
mv "$w_dir/$gifname.gif" "/home/onikom/Pictures/$gifname.gif"
echo $gifname
#sleep 5

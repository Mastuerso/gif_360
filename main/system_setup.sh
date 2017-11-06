#!/bin/bash
echo "System Setup"
#shopt -s lastpipe
sleep 1

setup_done=false
cameras_ready=false
capture_images=true
create_gif=false
capture_mode=true
dynamic_gif=false
dir=$(pwd)

function dummy {
    echo "dummy_function"
    echo -n "o" >/dev/ttyACM0
    capture_images=true
}

function capturetargetSD {
    bash "$dir/capture_target.sh"
}

function animate {
    capturetargetSD
    echo "Animating Gif"
    bash "$dir/animator.sh"
    capture_images=true    
}

function cleanDir {
    #cleanup images directory
    bash "$dir/remover.sh"
}

function take_pics {
    echo "take pics function ... "
    cleanDir
    count=$((0))
    cameras_no=${#cam_list[@]}
    echo "number of cameras: $cameras_no"
    if [ "$freeze" == "false" ]; then
        echo "Dynamic gif"
        while [ $cameras_no -gt $count ]; do
            i=${cam_list[$count]}
            count=$(( count + 1 ))            
            nohup gphoto2 $i gphoto2 --trigger-capture &
            sleep $cam_delay
        done
        count=$((0))
        sleep 6
    else
        echo "Freezed Gif"
    fi
    echo "Recovering Imagery"
    while [ $cameras_no -gt $count ]; do
        pic_name="$((count + 10)).JPG"
        i=${cam_list[$count]}
        count=$(( count + 1 ))
        nohup gphoto2 $i --get-all-files --filename "$(pwd)/images/$pic_name" --force-overwrite &
    done    
    count=$((0))
    sleep 3    
    animate
    while [ $cameras_no -gt $count ]; do
        pic_name="$((count + 10)).JPG"
        i=${cam_list[$count]}
        count=$(( count + 1 ))
        gphoto2 $i --delete-all-files --folder=/store_00020001/DCIM/100CANON        
    done
    echo "Files recovered"
    echo "Files deleted"    
}

#Detect cameras
echo "Detecting cameras ..."
while [ $cameras_ready == "false" ]; do
    gphoto2 --auto-detect > cam_list.txt
    file="$dir/cam_list.txt"
    line_count=$((0))
    cam_count=$((0))
    while IFS= read line; do
        line_count=$(( line_count + 1 ))
        if [ $line_count -ge $((3)) ]; then
            cam_count=$(( cam_count + 1 ))
            line=${line:22}
            line="--port="${line//[[:space:]]/}
            cam_port[$cam_count]=$line
            #echo "${cam_port[$cam_count]}"
        fi
    done <"$file"
    if [ $cam_count -gt $((0)) ]; then
        capturetargetSD
        cameras_ready=true
        echo "$cam_count cameras detected"
        #Sorting cameras
        echo "Sorting cameras, please wait ..."
        count=$((1))
        while [ $count -le $cam_count ]; do
            gphoto2 ${cam_port[$count]} --get-config=ownername > ownername.txt
            file="$dir/ownername.txt"
            linecount=$((0))
            while IFS= read cam_no; do
                linecount=$((linecount + 1))
                if [[ $linecount == $((3)) ]]; then
                    cam_number=${cam_no:12}
                    #echo "$cam_number is at ${cam_port[$count]}"           
                    cam_ordis[${cam_number}]=${cam_port[$count]}
                fi
            done <"$file"
            count=$(( count + 1 ))
        done        
        cameras_no=${#cam_ordis[@]}
        for i in "${cam_ordis[@]}"; do
            #echo "$i"
            cameras_no=$(( cameras_no - 1 ))            
            cam_list[$cameras_no]=$i #Camera Indez normalized           
        done
        echo "${#cam_list[@]} Cameras sorted"
        setup_done=true
        echo -n "r" >/dev/ttyACM0
    else
        echo "Please connect the cameras ..."
        sleep 60
    fi
done

#Take and recover photographies
echo "Taking and recovering photographies ..."
while $setup_done; do
    
    #Read Gif Settings
    if $capture_images; then
        #echo "Selecting gif type"
        file="$dir/gif_settings.txt"
        line=$(sed '6q;d' $file)
        #echo $line
        line=${line:7}
        if [ $line -eq $((0)) ]; then
            #echo "Dynamic"
            line=$(sed '7q;d' $file)
            #echo $line
            line=${line:8}
            echo "cam delay: ${line}ms"
            cam_delay=$(bc <<< "scale=3;$line/$((1000))")
            echo -n "d" >/dev/ttyACM0
        else
            #echo "Frezzed"
            echo -n "f" >/dev/ttyACM0
        fi
    fi
    
    file="$dir/results.txt"
    timeout 0.1 cat </dev/ttyACM0 | tee $file
    line=$(sed '3q;d' $file)
    if [[ "$line" == Ready* ]]; then
        capture_images=true
    elif [[ "$line" ==  Freezed* ]]; then
        capture_images=false
        freeze=true
    elif [[ "$line" ==  Dynamic* ]]; then
        capture_images=false
        freeze=false
    fi    
    #while IFS= read line; do
    #    if [[ "$line" == Ready* ]]; then            
    #        capture_images=true
    #        break
    #    elif [[ "$line" ==  Freezed* ]]; then
    #        echo "Did the cameras shoot?"
    #        capture_images=false
    #        freeze=true
    #        #dummy
    #        #take_pics
    #        break
    #    elif [[ "$line" ==  Dynamic* ]]; then
    #        echo "Let me do the hardwork"
    #        capture_images=false
    #        freeze=false
    #        #dummy
    #        #take_pics
    #        break
    #    fi
    #done <"$file"
    if $capture_images; then
        echo "Take some pictures"
    else
        if $freeze; then
            echo "Freezed gif"
        else
            echo "Dynamic gif"
        fi
        #echo "Dummy function"
        #dummy
        take_pics
    fi
    #Animate Gif
    #echo "Animating gif"
    #animate
done

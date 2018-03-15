#!/bin/bash
INPUT=$1
#echo "$INPUT" 1>&2
COUNT=$((0))
INDEX=$((0))
dir=$(pwd)
gif_dir_x=$dir/gifs/$(date +%b%d_%k%M_%S)
gif_dir=$(echo ${gif_dir_x//[[:blank:]]/})
echo "Saving pictures to: $gif_dir" 1>&2
mkdir -p $gif_dir/images
cp $dir/gif_settings.txt $gif_dir
#Number of lines
LineCount=$(echo "${INPUT}" | wc -l)
LineCount=$((LineCount - 1))
#echo "LineCount: $LineCount" 1>&2

while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    pic_name="image-$((COUNT + 10)).JPG"
    pic_names[$INDEX]="$pic_name"
    #pic_name=`printf %04d%s ${a%*}`.JPG
    #echo "Saving from camera at: $line" 1>&2
    nohup gphoto2 "$line" --get-all-files --filename "$gif_dir/images/$pic_name" --force-overwrite &
    #gphoto2 "$line" --get-all-files --filename "$gif_dir/images/$pic_name" --force-overwrite
    #gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON
    INDEX=$((INDEX +1))
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"

#CHECK IMGs HERE
thisDir=$(bash $dir/file_check.sh $gif_dir/images JPG $INDEX)
echo "ARE ALL IMAGES HERE? $thisDir" 1>&2
#IS CALIBRATED?
calibrated=$(bash $dir/lookup.sh calibrated gif_settings.txt)
echo "IS THIS CALIBRATED? $calibrated" 1>&2

COUNT=$((0))
while read -r line; do
  if [[ $COUNT -gt 0 ]] && [[ $COUNT -lt $LineCount ]]; then
    #echo "Deleting pictures fro camera at:" 1>&2
    #gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON
    nohup gphoto2 $line --delete-all-files --folder=/store_00020001/DCIM/100CANON &
  fi
  COUNT=$((COUNT + 1))
done <<< "${INPUT}"

if [ "$thisDir" == "valid dir" ]; then
    if [[ $calibrated -eq $((1)) ]]; then
	#bash "$dir/switchFox.sh"
	#python "$dir/apli_calculate_calib.py" $gif_dir
        bash "$dir/do_video.sh" "$gif_dir"
        echo "$gif_dir" >> chore.list
    else
        echo "Calculating calibration parameters ..." 1>&2
	      #bash "$dir/switchFox.sh"
        #INSERT HERE OPENCV SCRIPT << after this script finish it has to modify gif_settings.txt
        python "$dir/calculate_calib.py" $gif_dir
        #python "$dir/creacion_puntos.py" $gif_dir $((40))
        #python "$dir/calculate_calib.py" $gif_dir
        #sleep 5
        #python "$dir/calibrar_imagenes.py" $gif_dir
        #and set calibrated=1
        calibrated=$(bash $dir/lookup.sh calibrated gif_settings.txt)
        if [[ $calibrated -eq $((1)) ]]; then
            echo "Success" 1>&2
            #bash "$dir/switchFox.sh"
            #Applying sessions settings
            bash "$dir/auto_config.sh" "${INPUT}"
        fi
    fi
fi

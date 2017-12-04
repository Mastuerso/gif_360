#!/bin/bash
dir=$1
echo "$dir1"
imgList=$(ls -1 $dir/images/*.JPG)
echo "$imgList" 1>&2
LineCount=$(echo "${imgList}" | wc -l)
echo "$LineCount" 1>&2
for (( i = 0; i < $LineCount; i++ )); do
  if [[ $i -gt 0 ]] && [[ $i -lt $((LineCount)) ]]; then
    inv_numb=$((LineCount*2 -i + 10))
    currentImg=$(echo "$imgList" | sed -n "$i"p)
    echo "current image : $currentImg" 1>&2
    newNumber=$((inv_numb))
    cp "$currentImg" "$dir/images/image-$newNumber.JPG"    
  fi
done

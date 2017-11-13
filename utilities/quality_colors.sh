#!/bin/bash
#gif optimization
gif=$1
quality=$2
convert $gif -resize "$quality%" "S$1"
convert "S$1" -dither Riemersma -colors 64 "SC$1"


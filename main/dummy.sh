#!/bin/bash
dir=$(pwd)/images
ffmpeg -framerate 10 -pattern_type glob -i $dir/'*.JPG' -c:v libx264 -pix_fmt yuv420p $dir/'out.mp4'
#!/bin/bash
echo "Erasing"
sleep 1
dir=$(pwd)
rm -f ${dir}/images/*JPG
echo "done!"

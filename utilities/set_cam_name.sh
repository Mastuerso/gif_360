#!/bin/bash
name=$1
gphoto2 --auto-detect
gphoto2 --set-config ownername=$name
gphoto2 --get-config=ownername

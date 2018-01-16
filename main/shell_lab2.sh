#!/bin/bash
a=10
b=`printf %04d%s ${a%*}`.JPG
echo "$b"
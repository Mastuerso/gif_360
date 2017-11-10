#!/bin/bash
#image optimization
#convert $1 -strip -quality 85 BlowerQ.gif 
#gif optimization
#convert $1  -layers OptimizePlus opt_plus.gif
#get gif frames
#convert $1 out%05d.JPG
#optimize multiple images
#for f in *.JPG; do
#  convert ./"$f" -strip -quality 85 ./"${f%.JPG}.JPG"
#done
#mogrify -format pdf -- *.jpg
#get colors from file
#convert $1 -unique-colors -scale 1000%  colors.gif
#reduce number of colors
convert $1  -dither None -colors 64  colors_64_no.gif
convert $1  -dither Riemersma  -colors 64  colors_64_rm.gif
convert $1  -dither FloydSteinberg -colors 64  colors_64_fs.gif
convert $1 +dither -colors 8  colors_8_no.gif
convert $1 -dither Riemersma   -colors 8  colors_8_rm.gif
convert $1 -dither FloydSteinberg -colors 8  colors_8_fs.gif
#changing color Quantization
for S in    RGB CMY sRGB GRAY XYZ LAB LUV HSL HSB HWB YIQ YUV OHTA ; do
    convert $1   -quantize $S +dither -colors 16 -fill black -gravity SouthWest -annotate +2+2 $S colors_space_$S.gif
done
#web safe coloring
convert $1 -remap netscape:  remap_netscape.gif
convert $1 +dither -remap netscape:  remap_netscape_nd.gif
#posterize
convert $1 +dither -posterize 2  posterize_2_cw.gif
convert $1 +dither -posterize 3  posterize_3_cw.gif
convert $1 +dither -posterize 6  posterize_6_cw.gif
#posterize dither enabled
convert $1 -posterize 2 posterize_2_dcw.gif
convert $1 -posterize 3 posterize_3_dcw.gif
convert $1 -posterize 6 posterize_6_dcw.gif
#ordered ditter
convert $1  -ordered-dither o8x8,2 posterize_2_od.gif
convert $1  -ordered-dither o8x8,3 posterize_3_od.gif
convert $1  -ordered-dither o8x8,6 posterize_6_od.gif

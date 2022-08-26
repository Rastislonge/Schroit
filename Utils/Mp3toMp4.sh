#!/bin/bash

# Create mp4 (you can't directly convert this to webm)
for i in *.mp3;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  end=`ffmpeg as ffmpeg -i "${name}.mp3" 2>&1 | grep -Po "(?<=: )(.*)(?=\.[0-9][0-9],)"`
  echo "$end"
  ffmpeg -y -i "$i" -i /home/rastislonge/Schroit/Albums/dark.png -ss 00:00:00 -to "$end" -ar 96k -colorspace bt2020nc -color_primaries bt2020 -color_trc smpte2084 -dst_range 1 -src_range 1 -color_range 2 -sws_flags +accurate_rnd+full_chroma_int+full_chroma_inp -sws_dither none -sar 1:1 -fflags +igndts -fflags +genpts -vsync 1 -r 30 -pix_fmt yuv422p12le -filter_complex "[1:v]loop=loop=-1:start=0:size=450,boxblur=0:0:0:0:3:1,fps=30[img]; [0:a]highpass=f=1,acompressor=level_in=8:threshold=0.125:detection=peak:ratio=4,acompressor=level_in=16:threshold=0.24:detection=peak:ratio=4,volume=2.2,showfreqs=colors=cyan|magenta:mode=bar:fscale=lin:ascale=lin:win_size=256:size=1920x500,format=rgba,lagfun=decay=0.06:planes=1,fps=60,colorkey=color=0x00000000:similarity=0.02:blend=0,drawgrid=w=15:h=0:t=1:replace=1:c=0x00000000,colorkey=color=black,hue=H=t,split=2[x1][x2];[x1]vflip[x3];[x2][x3]vstack[v1]; [img][v1]overlay" "./Mp4/${i%.*}.mp4" 
done

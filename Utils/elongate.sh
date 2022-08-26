# Add 1 second of silence to broken mp3 (apart of the process for fixing mp3s that didn't convert well)
for i in *.mp3;
  do name=`echo "$i" | cut -d'.' -f1`
  ffmpeg -i "$i" -af "apad=pad_dur=1" "Longer/${name}.mp3"
done
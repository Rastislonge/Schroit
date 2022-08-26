# Get Covers
for i in *.mp3;
  do name=`echo "$i" | cut -d'.' -f1`
  ffmpeg -i "$i" -an -vcodec copy "Covers/${name}.jpg"
done
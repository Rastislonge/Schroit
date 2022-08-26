#Copy all webms to their respective album directory
$Schroit = "Schroit site\Schroit"
$Webm = "Schroit site\WebmB\"
exiftool\exiftool.exe $Schroit -CSV -album -artist > "Schroit site\all_exif.csv"

$Albums = Import-Csv -Path "Schroit site\all_exif.csv"
$AlbumsArr=@()
$ArtistsArr=@()
foreach($Album in $Albums){
$AlbumsArr+=$Album.Album
$ArtistsArr+=$Album.Artist
}

$i=0
Get-ChildItem $Schroit | Foreach-Object {
cp $($Webm+$_.BaseName+".webm") $("Schroit site\Albums\"+$ArtistsArr[$i]+"\"+$AlbumsArr[$i]+"\Assets\webm")
#I did a whoopsie of moving files to the wrong spot so I used the line below instead of the one above as a fix: 
#Remove-Item $("Schroit site\Albums\"+$ArtistsArr[$i]+"\"+$AlbumsArr[$i]+"\*.*") | Where { ! $_.PSIsContainer }
$i++
}

#Because PS is so bad at garbarge collection (It might as well collect itself)
$Albums = $null
$Artists = $null
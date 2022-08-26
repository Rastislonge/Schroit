#This is for getting the *skeleton* within an album directory, it does not create the album directory
#This is also assuming the album cover has the same name as the album directory and is already within the album directory
$dirs = Get-ChildItem "Schroit site\Albums\Yoyo Wiggins"
foreach($dir in $dirs){
mkdir "$($dir)/Assets/Webm"
move "$($dir)/$($dir).jpg" "$($dir)/Assets/$($dir).jpg"
}
$location = "$HOME\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$files = Get-ChildItem $location | Where-Object {$_.length -gt 5000} 
ForEach ($file in $files) {cp $location\$file $HOME\Pictures\Wallpapers\$file.jpg}
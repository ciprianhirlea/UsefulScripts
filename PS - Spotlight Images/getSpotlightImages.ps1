# Set the location for Spotlight Images
$location = "$HOME\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"

# Select images that are over 5KB
$images = Get-ChildItem $location | Where-Object {$_.length -gt 40000} 

# Checking if folder exist
if (!(test-path $HOME\Pictures\Wallpapers\)){New-Item -Path "$HOME\Pictures\Wallpapers\" -ItemType Directory}

# Copy images to a wallpaper folder
ForEach ($image in $images) {Copy-Item $location\$image $HOME\Pictures\Wallpapers\$image.jpg}
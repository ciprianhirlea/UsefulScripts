# Set the location for Spotlight Images
$location = "$HOME\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$landscape = "$HOME\Pictures\Wallpapers"
$portrait = "$HOME\Pictures\Wallpapers\Portrait"

# Find images from Window Repository
$images = Get-ChildItem $location -File
# Create Variable used for determining image size
add-type -AssemblyName System.Drawing

# Ensure required folders are available
if (!(test-path $landscape)){New-Item -Path $destination -ItemType Directory}
if (!(test-path $portrait)){New-Item -Path $portrait -ItemType Directory}

# Copy images to correct folders
ForEach ($image in $images) {
    $imageName = $image.Name
    $jpg = New-Object System.Drawing.Bitmap $image.FullName

    if($jpg.Height -eq 1080){
        Copy-Item "$location\$imageName" -Destination "$landscape\$imageName.jpg"
        
    } elseif($jpg.Height -eq 1920){
        Copy-Item "$location\$imageName" -Destination "$portrait\$imageName.jpg"
        
    }
}

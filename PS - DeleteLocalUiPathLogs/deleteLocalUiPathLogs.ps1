#Requires -RunAsAdministrator

$users = Get-Content -Path "$HOME\Desktop\users.txt" #List of users
$path = "C:\Users\$user\AppData\Local\UiPath\Logs\" #Location of log files
$days = "-15" #Age of log files
$today = Get-Date #Get today's date
$deleteRange = $today.addDays($days) #find logs older than $days

foreach ($user in $users){
	Get-ChildItem $Path | Where-Object {$_.LastWriteTime -lt $deleteRange} | Remove-Item
}

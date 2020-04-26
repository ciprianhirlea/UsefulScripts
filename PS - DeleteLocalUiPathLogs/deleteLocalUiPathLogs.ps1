#Requires -RunAsAdministrator

$users = Get-ChildItem "C:\Users" | Select-String -Pattern "(\w{2}\-\w{3}\-\w{3}([0-2][0-9]))" #Get a list of users
$days = "-15" #Age of log files
$today = Get-Date #Get today's date
$deleteRange = $today.addDays($days) #find logs older than $days

foreach ($user in $users){
	Get-ChildItem "C:\Users\$user\AppData\Local\UiPath\Logs\" | Where-Object {$_.LastWriteTime -lt $deleteRange} | Remove-Item
} 
$config = "$HOME\Desktop\FreeSpace.txt"
$init = Test-Path -Path $config -ErrorAction SilentlyContinue
	if (!($init)){
		Write-Host "The Configuration file could not be found. Please enusre it exists and you have `nthe right permissions to access it." -foregroundColor Red -backgroundColor Black
		Write-Host "Config: $config"
		Return
	}	
$servers = Get-Content $config
foreach ($server in $servers){
	#Check for typos
	$Check = Test-Path -Path "\\$server\c$" -ErrorAction SilentlyContinue

	If($Check -match "True"){
		
		$Status = "True"
		
		# Print the letters used above and use them as a title
		Write-Host ('############# ' + $server +' #############').ToUpper() -ForegroundColor Green
		
		# List each volume and disk stats
		get-wmiobject win32_logicaldisk -ComputerName ($server)| 
		select Name,FileSystem,VolumeName,@{
			n="Total GB";e={[math]::round($_.size / 1GB,2)}},
			@{n="Free GB";e={[math]::round($_.freespace / 1GB,2)}},
			@{n="Free %";e={[math]::round(($_.freespace / $_.size) * 100,2)}} |
				Format-Table -Autosize
		} Else {
		Write-Host ($server.toUpper() + " could not be found. Please check the firewall settings and try again") -ForegroundColor Red -BackgroundColor Black
		}
}
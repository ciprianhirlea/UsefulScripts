# Get list of disks on the server and free space
get-wmiobject win32_logicaldisk |
select Name,FileSystem,VolumeName,
	@{
		n="Total(GB)";
		e={[math]::round($_.size / 1GB,2)}
	},
	@{
		n="Free(GB)";
		e={[math]::round($_.freespace / 1GB,2)}
	},
	@{
		n="Free %";
		e={[math]::round(($_.freespace / $_.size) * 100,2)}
	}
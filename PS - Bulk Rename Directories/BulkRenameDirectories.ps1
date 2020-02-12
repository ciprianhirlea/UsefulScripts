$path = Read-Host 'Insert Path'
Get-ChildItem -Path "$path\KMS*" -Directory | ForEach-Object {Rename-Item -Path $_.FullName -NewName ($_.FullName -Replace "\#.+","")}
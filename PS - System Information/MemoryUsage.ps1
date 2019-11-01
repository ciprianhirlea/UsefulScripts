$config = "$HOME\Desktop\memoryUsage.txt"
$init = Test-Path -Path $config -ErrorAction SilentlyContinue
	if (!($init)){
		Write-Host "The Configuration file could not be found. Please enusre it exists and you have `nthe right permissions to access it." -foregroundColor Red -backgroundColor Black
		Write-Host "Config: $config"
		Return
	}	

$Servers = Get-Content $config
$Array = @()
  
ForEach($Server in $Servers)
{
    $Server = $Server.trim()
 
    Write-Host "Processing $Server"
 
    $Check = $null
    $Processor = $null
    $ComputerMemory = $null
    $RoundMemory = $null
    $Object = $null
 
    # Creating custom object
    $Object = New-Object PSCustomObject
    $Object | Add-Member -MemberType NoteProperty -Name "Server Name" -Value $Server
 
    $Check = Test-Path -Path "\\$Server\c$" -ErrorAction SilentlyContinue
 
    If($Check -match "True")
    {
        $Status = "True"
 
        Try
        {
            # Processor utilization
            $Processor = (Get-WmiObject -ComputerName $Server -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
  
            # Memory utilization
            $ComputerMemory = Get-WmiObject -ComputerName $Server -Class win32_operatingsystem -ErrorAction Stop
            $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
            $RoundMemory = [math]::Round($Memory, 2)
        }
        Catch
        {
            Write-Host "Something went wrong" -ForegroundColor Red
            Continue
        }
 
        If(!$Processor -and $RoundMemory)
        {
            $RoundMemory = "(null)"
            $Processor = "(null)"
        }
 
        $Object | Add-Member -MemberType NoteProperty -Name "Memory %" -Value $RoundMemory
        $Object | Add-Member -MemberType NoteProperty -Name "CPU %" -Value $Processor
 
        # Display results for single server in realtime
        #$Object
  
        # Adding custom object to our array
        $Array += $Object
    }
    Else
    {
        $Object | Add-Member -MemberType NoteProperty -Name "Memory %" -Value "(null)"
        $Object | Add-Member -MemberType NoteProperty -Name "CPU %" -Value "(null)"
         
        # Display resutls for single server in realtime
        #$Object
  
        # Adding custom object to our array
        $Array += $Object
    }
}  
 
    If($Array)
    { 
        $Array | Sort-Object "Server Name"
 
        #$Array | Out-GridView
  
        #$Array | Export-Csv -Path "C:\Users\chirlea\desktop\results.csv" -NoTypeInformation -Force
    }
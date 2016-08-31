####### To check when system last rebooted | Event ID 1074 indicates system reboots 
get-eventlog -LogName System -Newest 1000 | Where-Object eventid -EQ '1074' | FT machinename, username, timegenerated -autosize
################ To get the WIN32 and CIM data of a computer | can user *disk* *memory* etc
Get-CimClass -ClassName *bios*
#### then can use below to get info on the hardware
Get-WmiObject -Class Win32_LogicalDisk
###### To append to PowerShell Module path ###############
 $newPath=$originalpaths+’;C:\Windows\System32\WindowsPowerShell\v1.0\Modules'
 ###### or user this  ###
 #Save the current value in the $p variable.
$p = [Environment]::GetEnvironmentVariable("PSModulePath")

#Add the new path to the $p variable. Begin with a semi-colon separator.
$p += ";C:\Windows\System32\WindowsPowerShell\v1.0\Modules"

#Add the paths in $p to the PSModulePath value.
[Environment]::SetEnvironmentVariable("PSModulePath",$p)

############################## Get specific Updates installed on computer########
Get-HotFix | Where-Object HotFixID -EQ KB3097966
######################### Get all the windows vms in a vmware environment ######################
 Get-View -ViewType VirtualMachine | where {$_.guest.guestfamily -eq "windowsguest" -and $_.runtime.PowerState -eq "poweredOn"} | Select -property Name

######################## Good Tips ##############
get-adcomputer -filter * | select -Property name, @{name='Computername';expression={$_.name}} | Get-service name bits
 ## Change the property from computername to name so u can pipe into servicer commands pipe to GM to see change by replacing from the get-service part.##custom column / calculated property

 invoke-command -computername computernamhere -Scriptblock{Get-CimInstance win32_operatingsystem -Property Caption}

 ### Start DSC Resourse Module 
 Install-DscResourceAddon

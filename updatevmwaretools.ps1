#Enter your vCenter Host
$vcenter = "qa-vc1"
################################
 

Add-PSsnapin VMware.VimAutomation.Core
 
#Connect to the vCenter server defined above. Ignore cert errors
Connect-VIServer $vcenter -wa 0
 
#Get the folder name. Update all VM's if blank
$folder = Read-Host "Which folder would you like to update? (Leave blank to update all VM's)"
 
#Check if the user entered a folder. If a folder was provided return only the VM's for that folder
If($folder)
{
Write-Host "Updating VM's in $folder"
$virtualmachines = Get-Folder $folder | Get-VM | select -expandproperty Name
}
 
#Else if the user left the folder blank, get all VM's
Else
{
Write-Host "Updating all VM's"
#Get all VM's in the vCenter and return only their names
$virtualmachines = Get-VM | select -expandproperty Name
}
 

ForEach ($vm in $virtualmachines)
{
Write-Host "Updating VMware Tools on $VM"

Update-Tools $vm -NoReboot
}
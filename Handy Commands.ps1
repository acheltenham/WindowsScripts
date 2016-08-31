ip # Get the version of .Net Framework Installed on a System 
 get-childitem "hklm:\\Software\Microsoft\Net Framework Setup\NDP\"
 
 #To access remote Powershell session 
 Enter-PSSession -Computername bos-ad1 -Credential tpn-hq\acheltenham
 # To Enable PS Remoting
 Enable-PSRemoting -Force
 # To test the connection get
 Test-WSMan ('use computer name here' ) 
 # Create 
 $PSVersionTable # To get the verion of Powershell 
 Get-Host #Similar to above 
 # Below to install ISE on WIndows Server 2008R2####
 Import-Module ServerManager 
 Add-WindowsFeature PowerShell-ISE
 ###################################################
 Invoke-Command -ComputerName bos-ad1 -ScriptBlock { Get-Service w* } # get service from remote system
 #without using PSsession 
 # To show dynamic ports RPC being used on a system ####
  netsh int ipv4 show dynamicport tcp
 ######################################
 query user ## to see who is logged into a system ##
 ## List of AD User password Expiry Dates##
 Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}

 ## List Users whose Passwords are set to never expire## 
 Get-ADUser -Filter  'PasswordNeverExpires -eq $true' | select name

## See what wsus server a system is connected to ###
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
#####################################################
Get-ADGroupMember engineroom | select name
### To get a listing of the members in a AD Group ###
#######################################################
Import-CSV -Path "c:\dnsbulktest.csv" | ForEach-Object
{ dnscmd.exe $_.dnsserver /RecordAdd $_.zone $_.name /createPTR $_.type $_.IP }
##above code to enter mulitple entires in different dns servers to monitor replication####
get-adUser -Filter * -SearchBase "CN=Users,dc=hq,dc=tpn,dc=thinkingphones,dc=net" | Select-Object -Property SamAccountName, UserPrincipalName, name | Out-File c:\ADdump.txt
## above spit out all the AD users in a domain ###
#### To bulk add DNS Records ########
Import-CSV -Path "c:\dnsbulklist.csv" | ForEach-Object { dnscmd $_.dnsserver /RecordAdd $_.zone $_.name $_.type $_.IP }
#######################################################
### To get what FSMO Roles are running on server 
netdom /query fsmo 
######################################################
#### To Seize FMO Role from another server use the command Windows Server 2012R2#####
Move-ADDirectoryServerOperationMasterRole -Identity "ServerYouMOvingFSMOto" -OperationMasterRole RIDMaster,SchemaMaster -Force
#########################################################
get-aduser -Filter 'Name -like "*bre*"' |Format-Table Name,SamAccountName -AutoSize
### Use above to find users in Active directory by Name #####
#################################################################
#### To get the SOA of a Zone in on a specific DNS Server########
nslookup -type=soa tpn.thinkingphones.net cam-vm-ad1
#### note  you can use -type=cname -type=mx -type=ns etc..#######
### ADD AD Group ###
New-ADGroup -name "ANALYTICS_Viewer_ENG" -SamAccountName ANALYTICS_Viewer_ENG -GroupCategory Security -GroupScope Global -DisplayName ANALYTICS_Viewer_ENG -Path "OU=Security Groups,OU=Thinkingphones,DC=hq,DC=tpn,DC=thinkingphones,DC=net" -Description "Can be anything you want here" 
######
Import-Csv C:\Users\achelteham\Documents\PwrShell\groupname.csv | ForEach-Object {New-ADObject -Name $_.groupname -Type 'nisNetGroup' -Path 'OU=Machine Groups,OU=Production,OU=Linux Data,OU=Thinkingphones,DC=hq,DC=tpn,DC=thinkingphones,DC=net'} 
########## use to install modules from Powershell Gallery #############
Find-Module *mv* | Install-Module
#### to list modudles installed 
Get-Module -ListAvailable
####3In many cases, you will be able to work with remote computers in other domains. However, if the remote computer is not in a trusted domain,
##### the remote computer might not be able to authenticate your credentials. To enable authentication, 
#######you need to add the remote computer to the list of trusted hosts for the local computer in WinRM. To do so, type: 
winrm s winrm/config/client '@{TrustedHosts="RemoteComputer"}'
#############
Get-windowsfeature
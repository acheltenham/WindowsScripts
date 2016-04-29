[DSCLocalConfigurationManager()]
Configuration LCMPUSH 
{	
	Node $Computername
	{
		SEttings
		{
			AllowModuleOverwrite = $True
            ConfigurationMode = 'ApplyAndAutoCorrect'
			RefreshMode = 'Push'
            RebootNodeIfNeeded = $True	
		}
	}
}

$Computername = 'localhost'

# Create the Computer.Meta.Mof in folder
LCMPush -OutputPath c:\DSC\LCM

Set-DscLocalConfigurationManager -Computername $computername -Path c:\DSC\LCM -verbose



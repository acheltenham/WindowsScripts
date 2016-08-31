<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function add-functionalrole
{
    [CmdletBinding()]
    Param
    (
        # Catchign the user or users, can be piped from a file or directly from AD query 
        
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromPipeline=$true,
                   HelpMessage="Enter Username here First Intial + Lastname",
                   Position=0)]
        [Alias('SamAccountname')]
        [String[]]$identity,
        
        [Parameter(ParameterSetName='Role')],
        [String]$QAEngineer
        
    )

    Begin
    {
    $qaeng = ('Border_Viewer_ENG','CallFS_Viewer_ENG','Conf_Viewer_ENG','Fax_Viewer_ENG',
'CallGW_Viewer_ENG','CallGWS_Viewer_ENG','OpenSips_Viewer_ENG','CallFS_Viewer_ENG','SIPDP_Viewer_ENG',
'TCC_Viewer_ENG','VMFS_Viewer_ENG','ZoneSrv_Viewer_ENG')
        
    }
    Process
    {
     foreach ($eng in $qaeng)
        {
        Add-ADGroupMember -Identity $eng -Members $identity -Server bos-ad1
        }
    }
    End
    {
        Write-Output "User added to QA Engineer Role"
    }
}
### AWS Set up profile 
Set-AWSCredentials -AccessKey AKIAJJBTDIIKL67RBY3Q -SecretKey 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 -StoreAs SSO
## Check list of profiles
Get-AWSCredentials -ListStoredCredentials
## Remove Profile
Clear-AWSCredentials -StoredCredentials (profilename)
## To use a profile for a sesison 
Set-AWSCredentials -ProfileName SSO
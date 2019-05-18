Param(
    [Parameter(Mandatory=$true)]
    [String]$vCenter,
    [Parameter(Mandatory=$true)]
    [String]$PrivateFilePath
)
$logincred = Get-Credential -Message "vSphere Login"
$UserName = $logincred.UserName
$SecurePassword = $logincred.Password
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

$oldContent = Get-Content -Path .\variables.tf

$newContent = ($oldContent -replace "DEFAULT_USERNAME",$UserName)
$newContent = ($newContent -replace "DEFAULT_PASSWORD",$UnsecurePassword)
$newContent = ($newContent -replace "FILE_PATH",$PrivateFilePath)
$newContent = ($newContent -replace "VCENTER_SERVER",$vCenter)

$newContent | Set-Content -Path .\variables.tf

terraform plan

terraform apply -auto-approve

$oldContent | Set-Content -Path .\variables.tf
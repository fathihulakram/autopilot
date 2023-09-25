# Retrieve the encrypted password from the file
$EncryptedPassword = '76492d1116743f0423413b16050a5345MgB8AEQASwBDAEcASABzADAAbgBxAGIAegBKAEMAUQBpAFoAcgBFADMAOQAyAEEAPQA9AHwANQBjAGMAOAA3AGQAMQA0AGEANwBjAGQANAA5AGIAZAA3ADgAYQA5ADgAMwAwAGYAZQA3AGQAMgA0ADYAYgA5ADAANQBhAGMAYQBlAGEAZABjADkAZQAxAGQAMABjAGMAMQA4AGEAMQA1ADgAOAA1ADMAMABlADQAOABiAGUAYQA='

# Decrypt the password
$SecureStringPassword = ConvertTo-SecureString -String $EncryptedPassword -Key (1..16)

$params = @{
    Name                = 'EnfraAdmin'
    Password            = $SecureStringPassword
    PasswordNeverExpires = $true
    FullName            = 'EnfraAdmin'
    Description         = 'Enfrasys Device Local Administrator.'
}

New-LocalUser @params

# Add EnfraAdmin to Admin group
Add-LocalGroupMember -Group "Administrators" -Member "EnfraAdmin"

# Install NuGet Provider
Install-PackageProvider -Name NuGet -Force

# Install Autopilot module
Install-Script -name Get-WindowsAutopilotInfo -Force

Get-WindowsAutopilotInfo -Online

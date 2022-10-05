Import-Module ActiveDirectory

$OU = "OU=CCI,DC=office,DC=login"
$DaysInactive = 90
$Time = (Get-Date).Adddays( - ($DaysInactive))

Get-ADUser -Filter { LastLogonTimeStamp -lt $Time -and enabled -eq $true } -SearchBase $OU -Properties * |
Select-Object Name, LastLogonDate |

Export-Csv "c:\temp\InactiveUsersOU_CCI.csv" -Encoding UTF8 -NoTypeInformation

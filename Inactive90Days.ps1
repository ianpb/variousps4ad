Import-Module ActiveDirectory

$OU = "OU=CCBWI,DC=officeSouth,DC=login"
$DaysInactive = 90
$Time = (Get-Date).Adddays( - ($DaysInactive))

Get-ADUser -Filter { LastLogonTimeStamp -lt $Time -and enabled -eq $true } -SearchBase $OU -Properties * |
Select-Object Name, LastLogonDate |

Export-Csv "c:\temp\InactiveUsersOU_CCI.csv" -Encoding UTF8 -NoTypeInformation

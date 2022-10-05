#Export AD Users with Name and Dept
Get-ADUser -Filter * -SearchBase "OU=Users,OU=CCI,DC=office,DC=login" -Properties * | Select-Object name,department | export-csv -path c:\temp\userexportAll.csv

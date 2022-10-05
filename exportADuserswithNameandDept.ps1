#Export AD Users with Name and Dept
Get-ADUser -Filter * -SearchBase "OU=Users,OU=CBCI,DC=officeSouth,DC=login" -Properties * | Select-Object name,department | export-csv -path c:\temp\userexportAll.csv

#Read security group details from CSV file
$CSVRecords = Import-CSV "C:\temp\hdms.csv"
  
#Iterate groups one by one and create
ForEach($CSVRecord in $CSVRecords)
{
$GroupName = $CSVRecord."Name"
$GroupDescription = $CSVRecord."Description"
#Split owners and members by semi-colon separator (,) and set in array
$Owners = If($CSVRecord."Owners"){ $CSVRecord."Owners" -split ',' } Else { $null }
$Members = If($CSVRecord."Members"){ $CSVRecord."Members" -split ',' } Else { $null }
$OwnrObjtIDs = If($CSVRecord."OwnersID"){ $CSVRecord."OwnersID" -split ',' } Else { $null }
$ObjctIDs = If($CSVRecord."MembersID"){ $CSVRecord."MembersID" -split ',' } Else { $null }
 
#Create a new security group
$NewGroupObj = New-AzureADGroup -DisplayName $GroupName -SecurityEnabled $true -Description $GroupDescription  -MailEnabled $false -MailNickName "NotSet" -ErrorAction Stop
 
#Add owners
ForEach($OwnrObjtID in $OwnrObjtIDs)
{
#Add owner to the new group
Add-AzureADGroupOwner -ObjectId $NewGroupObj.ObjectId -RefObjectId $OwnrObjtID -ErrorAction Stop
}

#Add members 
ForEach($ObjctID in $ObjctIDs)
{
#Add a member to the new group
Add-AzureADGroupMember -ObjectId $NewGroupObj.ObjectId -RefObjectId $ObjctID  -ErrorAction Stop
}
}


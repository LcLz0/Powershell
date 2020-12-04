################## Initalise main importVars ##################

$infoDump = Import-Csv -Path "F:\userlist.csv"
$groups = Import-Csv -Path "F:\groups.csv"
$subUnits = Import-Csv -Path "F:\subUnits.csv"

################## Create main OU-structure ##################

# Get list of unique cities
$uniqCities = $infoDump.stad | Select-Object -Unique

### Create OU-structure

# Create static top level OUs
New-ADOrganizationalUnit -Name:"Resursgrupper" -Path:"DC=cyberdyne,DC=io"  -ProtectedFromAccidentalDeletion:$false
New-ADOrganizationalUnit -Name:"Servers" -Path:"DC=cyberdyne,DC=io"  -ProtectedFromAccidentalDeletion:$false

# Create toplevel OU
foreach ($City in $uniqCities)
{
  New-ADOrganizationalUnit -Name:"$City" -Path:"DC=cyberdyne,DC=io"  -ProtectedFromAccidentalDeletion:$false

  # Create subOu in each toplevel
  foreach ($subOu in $subUnits)
  {
    New-ADOrganizationalUnit -Name:$subOu.subOu -Path:"OU=$City,DC=cyberdyne,DC=io" -ProtectedFromAccidentalDeletion:$false
  }

  # Create groups in each City
  foreach ($grp in $groups)
  {
    $grpName = $grp.gName
    $grpSAM = $City + "s" + $grp.gName
    New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:$grpName -Path:"OU=Groups,OU=$City,DC=cyberdyne,DC=io" -SamAccountName:$grpSAM
  }

}

################## Loop through user list and create all user accounts ##################

foreach ($User in $infoDump)
{   # Main block

	# Let's populate some variables, SAM creation further down
    $FirstName = $User.fName
    $LastName = $User.sName
    $Displayname = $User.dName
    $Description = $User.department
    $Mobile = $User.phone
    $Address = $User.address
    $PostalCode = $User.zipCode
    $City = $User.city
    $OU = "OU=Users,OU=$City,DC=cyberdyne,DC=io"

	# SAM name creation https://4sysops.com/archives/strings-in-powershell-replace-compare-concatenate-split-substring/
	# $name.Remove(0.99) Remove everything except first char
	# STRING.ToLower() to change all to lowercase
    $SAM = $FirstName.Remove(0.99) + $LastName
    $SAM = $SAM.ToLower()
    $SAM = ($SAM -replace "Å","A")
    $SAM = ($SAM -replace "Ä","A")
    $SAM = ($SAM -replace "Ö","O")
    $UPN = "$SAM" + "@cyberdyne.io"

	# Run commands with above vars
    New-ADUser -Name "$Displayname" -GivenName $FirstName -Surname $LastName -Description $Description -MobilePhone $Mobile -StreetAddress "$Address" -PostalCode "$PostalCode" -City $City -Path "$OU" -SamAccountName "$SAM" -UserPrincipalName "$UPN"
    #Unlock-ADAccount -Identity $SAM



    # Add users to groups, using Description to choose group

    if ($Description -eq "Konsult") {
      $grpSAM = $City + "s" + $grp.gName
      Add-ADGroupMember -Identity $grpSAM -Members $SAM
    }

    if ($Description -eq "Seniorkonsult") {
      $grpSAM = $City + "s" + $grp.gName
      Add-ADGroupMember -Identity $grpSAM -Members $SAM
    }

    if ($Description -eq "Säljare") {
      $grpSAM = $City + "s" + $grp.gName
      Add-ADGroupMember -Identity $grpSAM -Members $SAM
    }

    if ($Description -eq "Ekonom") {
      $grpSAM = $City + "s" + $grp.gName
      Add-ADGroupMember -Identity $grpSAM -Members $SAM
    }

    if ($Description -eq "Vaktis") {
      $grpSAM = $City + "s" + $grp.gName
      Add-ADGroupMember -Identity $grpSAM -Members $SAM
    }
}

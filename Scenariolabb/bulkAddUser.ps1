################## Initalise main importVars ##################
$infoDump = Import-Csv -Path "F:\anvandarlistatest.csv"
$groups = Import-Csv -Path "F:\groups.csv"
$subUnits = Import-Csv -Path "F:\subUnits.csv"


################## Create main OU-structure ##################

#  $stadad = $infoDump.stad | Select-Object -Unique

# Get list of unique cities
$uniqCities = $infoDump.stad | Select-Object -Unique

# Create OU-structure

# Create toplevel OU
foreach ($City in $uniqCities)
{
  #New-ADOrganizationalUnit -Name:"$City" -Path:"DC=jultomten,DC=nu"  -ProtectedFromAccidentalDeletion:$false
  echo $City
  # Create subOu in each toplevel
  foreach ($subOu in $subUnits)
  {
    #New-ADOrganizationalUnit -Name:"$subOu.subOu" -Path:"OU=$City,DC=jultomten,DC=nu" -ProtectedFromAccidentalDeletion:$false
    echo $subOu.subOu
  }

  # Create groups in each City
  foreach ($grp in $groups)
  {
    $grpName = $City + "s" + $grp.gName
    echo $grpName
    #New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:"$grpName" -Path:"OU=Grupper,OU=$City,DC=jultomten,DC=nu" -SamAccountName:"$grpName" -Server:"DC.jultomten.nu"
  }

}

<#





foreach ($User in $Users)
{   # Main block

	# Let's populate some variables, SAM creation further down
    $FirstName = $User.fNamn
    $LastName = $User.lNamn
    $Displayname = $User.dName
    $Description = $User.avdelning
    $Mobile = $User.tele
    $Address = $User.adress
    $PostalCode = $User.postNr
    $City = $User.stad
    $OU = "OU=Användare,OU=$City,DC=jultomten,DC=nu"

	# SAM name creation https://4sysops.com/archives/strings-in-powershell-replace-compare-concatenate-split-substring/
	# $name.Remove(0.99) Remove everything except first char
	# STRING.ToLower() to change all to lowercase
    $SAM = $FirstName.Remove(0.99) + $LastName
    $SAM = $SAM.ToLower()
    $UPN = "$SAM" + "@jultomten.nu"

	# Run commands with above vars
    New-ADUser -Name "$Displayname"-GivenName $FirstName -Surname $LastName -Description $Description -MobilePhone $Mobile -StreetAddress "$Address" -PostalCode "$PostalCode" -City $City -Path "$OU" -SamAccountName "$SAM" -UserPrincipalName "$UPN"
    Unlock-ADAccount -Identity $SAM
}

<#
    # Add users to groups, using Description to choose group

    if ($Description -eq "Konsult") {
        # Lägg till i grupp Konsulter
    }

    if ($Description -eq "Seniorkonsult") {
        # Lägg till i grupp Seniorkonsulter
    }

    if ($Description -eq "Säljare") {
        # Lägg till i grupp Försäljningsavdelning
    }

    if ($Description -eq "Ekonom") {
        # Lägg till i grupp Ekonomi och Redovisning
    }

    if ($Description -eq "Vaktis") {
        # Lägg till i OU-lokala admingrupper. Väntar på lösning
    }
}#>

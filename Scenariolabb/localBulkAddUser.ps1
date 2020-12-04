################## Initalise main importVars ##################

$infoDump = Import-Csv -Path "F:\userlist.csv"
$groups = Import-Csv -Path "F:\groups.csv"
$subUnits = Import-Csv -Path "F:\subUnits.csv"

################## Create main OU-structure ##################

# Get list of unique cities
$uniqCities = $infoDump.stad | Select-Object -Unique
echo "uniqCities = $uniqCities"

### Create OU-structure

# Create toplevel OU
foreach ($City in $uniqCities)
{
  echo "City = $City"

  # Create subOu in each toplevel
  foreach ($subOu in $subUnits)
  {
    echo "subOu = $subOu.subOu"
  }

  # Create groups in each City
  foreach ($grp in $groups)
  {
    $grpName = $City + "s" + $grp.gName
    echo "grpName = $grpName"
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
    $UPN = "$SAM" + "@jultomten.nu"

    echo "Displayname = $Displayname"
    echo "City = $City"
    echo "OU-path = $OU"
    echo "SAM = $SAM"
    echo "UPN = $UPN"

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

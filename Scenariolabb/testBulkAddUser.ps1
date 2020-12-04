################## Initalise main importVars ##################

$infoDump = Import-Csv -Path "F:\userlist.csv"
$groups = Import-Csv -Path "F:\groups.csv"
$subUnits = Import-Csv -Path "F:\subUnits.csv"

################## Create main OU-structure ##################

# Get list of unique cities
$uniqCities = $infoDump.stad | Select-Object -Unique
echo "Getting unique cities from userlist. uniqCities = $uniqCities"

### Create OU-structure

# Create toplevel OU
foreach ($City in $uniqCities)
{
  echo "Creating top level OU, named after city. City = $City"

  # Create subOu in each toplevel
  foreach ($subOu in $subUnits)
  {
    echo "Creating sub-OU in each City. City = $City subOu = $subOu.subOu"
  }

  # Create groups in each City
  foreach ($grp in $groups)
  {
    $grpName = $grp.gName
    $grpSAM = $City + "s" + $grp.gName
    echo "Creating groups for each city, for each department. Group name = $grpName with SAM = $grpSAM"
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

    echo "Creating user. Displayname = $Displayname"
    echo "City = $City"
    echo "OU-path = $OU"
    echo "SAM = $SAM"
    echo "UPN = $UPN"

}


    # Add users to groups, using Description to choose group

    if ($Description -eq "Konsult") {
      $grpName = $grp.gName
      $grpSAM = $City + "s" + $grp.gName
      echo "Adding user $SAM to User group $usrGrp"
    }

    if ($Description -eq "Seniorkonsult") {
      $usrGrp = $City + "sSeniorer"
      echo "Adding user $SAM to User group $usrGrp"
    }

    if ($Description -eq "Säljare") {
      $usrGrp = $City + "sSäljare"
      echo "Adding user $SAM to User group $usrGrp"
    }

    if ($Description -eq "Ekonom") {
      $usrGrp = $City + "sEkonomer"
      echo "Adding user $SAM to User group $usrGrp"
    }

    if ($Description -eq "Vaktis") {
      $usrGrp = $City + "sKonsulter"
      echo "Adding user $SAM to User group $usrGrp"
    }
}

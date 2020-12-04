################## Initalise main importVars ##################

$infoDump = Import-Csv -Path "C:\Users\loco\Documents\Kod\Powershell\Scenariolabb\userlistTest.csv"
$groups = Import-Csv -Path "C:\Users\loco\Documents\Kod\Powershell\Scenariolabb\groups.csv"
$subUnits = Import-Csv -Path "C:\Users\loco\Documents\Kod\Powershell\Scenariolabb\subUnits.csv"

################## Create main OU-structure ##################

# Get list of unique cities
$uniqCities = $infoDump.city | Select-Object -Unique
echo "Getting unique cities from userlist. uniqCities = $uniqCities"

### Create OU-structure

# Create toplevel OU
foreach ($City in $uniqCities)
{
  echo "Creating top level OU, named after city. City = $City"

  # Create subOu in each toplevel
  foreach ($subOu in $subUnits)
  {
    $sOu = $subOu.subOu
    echo "Creating sub-OU in each City. City = $City subOu = $sOu"
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
    <#$SAM = ($SAM -replace "Å","A")
    $SAM = ($SAM -replace "Ä","A")
    $SAM = ($SAM -replace "Ö","O")#>
    $UPN = "$SAM" + "@cyberdyne.io"

    echo "Creating user. Displayname = $Displayname"
    echo "City = $City"
    echo "OU-path = $OU"
    echo "SAM = $SAM"
    echo "UPN = $UPN"




    # Add users to groups, using Description to choose group

    if ($Description -eq "Konsult") {
      $grpSAM = $City + "s" + $grpName
      echo "Adding user $SAM to User group $grpName with SAM $grpSAM"
    }

    if ($Description -eq "Seniorkonsult") {
      $grpSAM = $City + "s" + $grpName
      echo "Adding user $SAM to User group $grpName with SAM $grpSAM"
    }

    if ($Description -eq "Säljare") {
      $grpSAM = $City + "s" + $grpName
      echo "Adding user $SAM to User group $grpName with SAM $grpSAM"
    }

    if ($Description -eq "Ekonom") {
      $grpSAM = $City + "s" + $grpName
      echo "Adding user $SAM to User group $grpName with SAM $grpSAM"
    }

    if ($Description -eq "Vaktis") {
      $grpSAM = $City + "s" + $grpName
      echo "Adding user $SAM to User group $grpName with SAM $grpSAM"
    }
}

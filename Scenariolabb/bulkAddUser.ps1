# Create groups
powershell.exe -File "F:\grpCreate.ps1"

# Loop through user list and create entries
$Users = Import-Csv -Path "F:\anvandarlistatest.csv"

foreach ($User in $Users)
{   # Main block

	# Let's populate some variables, SAM creation further down
    $FirstName = $User.fNamn
    $LastName = $User.lNamn
    $Displayname = $User.dNamn
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
}

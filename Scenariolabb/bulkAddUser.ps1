$Users = Import-Csv -Path "F:\anvandarlistatest.csv"
foreach ($User in $Users)
{
	# Let's populate some variables, SAM creation further down
    $FirstName = $User.fName
    $LastName = $User.lName
    $Displayname = $User.dName
  #  $UPN = $User.upn
    $Description = $User.avdelning
    $Mobile = $User.tele
    $Address = $User.adress
    $PostalCode = $User.postNr
    $City = $User.stad
    # Remember to change "domnain" to actual domain name
    $OU = 'OU=Användare,OU=' + $City + ',DC=domain,DC=nu'

	# SAM name creation https://4sysops.com/archives/strings-in-powershell-replace-compare-concatenate-split-substring/
	# $name.Remove(0.99) Remove everything except first char
	# STRING.ToLower() to change all to lowercase
	# $SAM = "$FirstName $LastName"

	# Run commands with above vars
    New-ADUser -Name "$Displayname" `
    -GivenName $FirstName `
    -Surname $LastName `
    -SamAccountName $SAM `
  #  -UserPrincipalName $UPN `
    -Description $Description `
    -MobilePhone $Mobile `
    -StreetAddress "$Address" `
    -PostalCode "$PostalCode" `
    -City $City `
    -Path "$OU"
}

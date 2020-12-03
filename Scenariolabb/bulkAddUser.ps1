$Users = Import-Csv -Path "F:\import3.csv"
foreach ($User in $Users)
{
	# Let's populate some variables, SAM creation further down
    $FirstName = $User.fName
    $LastName = $User.lName
    $Displayname = $User.dName
    $UPN = $User.upn
    $Office = $User.avdelning
    $Mobile = $User.tele
    $Address = $User.adress
    $PostalCode = $User.zip
    $City = $User.st
    $OU = 'OU=Anvandare,OU=' + $City + ',DC=jultomten,DC=nu'
	
	# SAM name creation https://4sysops.com/archives/strings-in-powershell-replace-compare-concatenate-split-substring/
	# $name.Remove(0.99) Remove everything except first char
	# STRING.ToLower() to change all to lowercase
	# $SAM = "$FirstName $LastName"
	
	# Run commands with above vars
    New-ADUser -Name "$Displayname" -GivenName $FirstName -Surname $LastName -SamAccountName $SAM -UserPrincipalName $UPN -Office $Office -MobilePhone $Mobile -StreetAddress "$Address" -PostalCode "$PostalCode" -City $City -Path "$OU"
}
New-ADOrganizationalUnit -Name "Servrar" -Path "DC=jultomten,DC=nu"
New-ADOrganizationalUnit -Name "Stockholm" -Path "DC=jultomten,DC=nu"
New-ADOrganizationalUnit -Name "Anvandare" -Path "OU=Stockholm,DC=jultomten,DC=nu"
New-ADOrganizationalUnit -Name "Datorer" -Path "OU=Stockholm,DC=jultomten,DC=nu"
New-ADOrganizationalUnit -Name "Grupper" -Path "OU=Stockholm,DC=jultomten,DC=nu"
New-ADUser -City:"Stockholm" -Company:"Nackademin" -Department:"Education" -Description:"Konsult" -DisplayName:"Love Lundin" -GivenName:"Love" -Name:"Love Lundin" -Office:"Solna" -Path:"OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -SamAccountName:"love" -Server:"DC.jultomten.nu" -Surname:"Lundin" -Title:"Konsult" -Type:"user" -UserPrincipalName:"love@jultomten.nu"
Set-ADAccountPassword -Identity:"CN=Love Lundin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Linux4Ever" -Force) -Server:"DC.jultomten.nu"
Enable-ADAccount -Identity:"CN=Love Lundin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:"CN=Love Lundin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -PasswordNeverExpires:$true -Server:"DC.jultomten.nu" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=Love Lundin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu" -SmartcardLogonRequired:$false
New-ADUser -City:"Stockholm" -Company:"Nackademin" -Department:"Education" -Description:"Konsult" -DisplayName:"Magnus Colding" -GivenName:"Magnus" -Name:"Magnus Colding" -Office:"Solna" -Path:"OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -SamAccountName:"Magnus" -Server:"DC.jultomten.nu" -Surname:"Colding" -Title:"Konsult" -Type:"user" -UserPrincipalName:"Magnus@jultomten.nu"
Set-ADAccountPassword -Identity:"CN=Magnus Colding,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Linux4Ever" -Force) -Server:"DC.jultomten.nu"
Enable-ADAccount -Identity:"CN=Magnus Colding,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:"CN=Magnus Colding,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -PasswordNeverExpires:$true -Server:"DC.jultomten.nu" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=Magnus Colding,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu" -SmartcardLogonRequired:$false
New-ADUser -City:"Stockholm" -Company:"Nackademin" -Department:"Education" -Description:"Utbildningsledare" -DisplayName:"Martin Devins" -GivenName:"Martin" -Name:"Martin Devins" -Office:"Solna" -Path:"OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -SamAccountName:"Martin" -Server:"DC.jultomten.nu" -Surname:"Devins" -Title:"Utbildningsledare" -Type:"user" -UserPrincipalName:"Martin@jultomten.nu"
Set-ADAccountPassword -Identity:"CN=Martin Devins,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Linux4Ever" -Force) -Server:"DC.jultomten.nu"
Enable-ADAccount -Identity:"CN=Martin Devins,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:"CN=Martin Devins,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -PasswordNeverExpires:$true -Server:"DC.jultomten.nu" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=Martin Devins,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu" -SmartcardLogonRequired:$false
New-ADUser -City:"Stockholm" -Company:"Nackademin" -Department:"Education" -Description:"Lärare" -DisplayName:"Erik Brodin" -GivenName:"Erik" -Name:"Erik Brodin" -Office:"Solna" -Path:"OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -SamAccountName:"Erik" -Server:"DC.jultomten.nu" -Surname:"Brodin" -Title:"Lärare" -Type:"user" -UserPrincipalName:"Erik@jultomten.nu"
Set-ADAccountPassword -Identity:"CN=Erik Brodin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Linux4Ever" -Force) -Server:"DC.jultomten.nu"
Enable-ADAccount -Identity:"CN=Erik Brodin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:"CN=Erik Brodin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -PasswordNeverExpires:$true -Server:"DC.jultomten.nu" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=Erik Brodin,OU=Användare,OU=Stockholm,DC=jultomten,DC=nu" -Server:"DC.jultomten.nu" -SmartcardLogonRequired:$false
New-ADGroup -Name "Stockholmsadmins" -SamAccountName Stockholmsadmins -GroupCategory Security -GroupScope Global -DisplayName "Stockholmsadmins" -Path "OU=Grupper,OU=Stockholm,DC=jultomten,DC=nu"
New-ADGroup -Name "Stockholmsanvändare" -SamAccountName Stockholmsanvändare -GroupCategory Security -GroupScope Global -DisplayName "Stockholmsanvändare" -Path "OU=Grupper,OU=Stockholm,DC=jultomten,DC=nu"
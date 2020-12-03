$Groups = Import-Csv -Path "F:\grupper.csv"
foreach ($Group in $Groups)
{
  $Grp = $Group.gName
  New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:"$Grp" -Path:"OU=Grupper,OU=Stockholm,DC=jultomten,DC=nu" -SamAccountName:"$grp" -Server:"DC.jultomten.nu"
  New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:"$Grp" -Path:"OU=Grupper,OU=Sundsvall,DC=jultomten,DC=nu" -SamAccountName:"$grp" -Server:"DC.jultomten.nu"
}

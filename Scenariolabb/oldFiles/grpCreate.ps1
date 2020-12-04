$Groups = Import-Csv -Path "F:\grupper.csv"
foreach ($Group in $Groups)
{
  $Grp = $Group.gName
  $sthlmGrp = "Stockholms$Grp"
  $svallGrp = "Sundsvalls$Grp"
  New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:"$sthlmGrp" -Path:"OU=Grupper,OU=Stockholm,DC=jultomten,DC=nu" -SamAccountName:"$sthlmGrpgrp" -Server:"DC.jultomten.nu"
  New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:"$svallGrp" -Path:"OU=Grupper,OU=Sundsvall,DC=jultomten,DC=nu" -SamAccountName:"$svallGrpgrp" -Server:"DC.jultomten.nu"
}

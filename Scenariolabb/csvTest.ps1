$Orter = Import-Csv -Path "C:\Users\loco\Documents\Git\Powershell\Scenariolabb\orter.csv"
$subOus = Import-Csv -Path "C:\Users\loco\Documents\Git\Powershell\Scenariolabb\subOu.csv"

ForEach ($Ort in $Orter)
{
    # Create toplevel OU

    ForEach ($subOu in $subOus)
    {
      # Create subOU in each toplevel OU
    }
}

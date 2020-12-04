$infoDump = Import-Csv -Path "C:\Users\loco\Documents\Git\Powershell\Scenariolabb\anvandarlistatest.csv"
$subOus = Import-Csv -Path "C:\Users\loco\Documents\Git\Powershell\Scenariolabb\subOu.csv"

ForEach ($Test in $infoDump)
{
    # Create toplevel OU
    echo $Test

  <#  ForEach ($subOu in $subOus)
    {
      echo $subOu
    }#>
}

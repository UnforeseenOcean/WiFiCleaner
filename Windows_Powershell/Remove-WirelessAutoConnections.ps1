$GUID = (Get-NetAdapter -Name 'wi-fi').interfaceGUID



$path = "C:\ProgramData\Microsoft\Wlansvc\Profiles\Interfaces\{CA42DF16-1224-4D48-A745-B561FD9CC420}"

$SafeNetworks = "B53E7C", "Onion Pi"

Get-ChildItem -Path $path -Recurse |

Foreach-Object {

   [xml]$c = Get-Content -path $_.fullname

   New-Object pscustomobject -Property @{

   'name' = $c.WLANProfile.name;

   'mode' = $c.WLANProfile.connectionMode;

   'ssid' = $c.WLANProfile.SSIDConfig.SSID.hex;


   'path' = $_.fullname} |

   Foreach-object {



     If($SafeNetworks -notcontains $_.Name)

        { 
        Write-Host $_.ssid
        Remove-Item $_.path } }

   }
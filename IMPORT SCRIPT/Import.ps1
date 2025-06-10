Import-Module ActiveDirectory
$ADusers = Import-Csv C:\users.csv
$OUpath = "OU=Kasutajad,dc=oige,dc=local"
foreach ($user in $ADusers) {
    write-host "Lisatud "$user.Nimi
    $firstname = $user.Nimi.Split(" ")[0]
    $lastname = $user.Nimi.Split(" ")[1]
    $SAM = $firstname + "." + $lastname
    $Name = $user.Nimi
    $Org = $user.Osakond
    $AccountPassword = (ConvertTo-SecureString "Passw0rd" -asplaintext -force)
    New-ADUser -Name $Name -userprincipalname ($SAM + "@" + "oige.local") -AccountPassword $AccountPassword -Enabled $true -path $OUpath -Department $Org -SamAccountName $SAM
    }
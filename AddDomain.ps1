Write-Host @"
########################################
##                                    ##
##  AddDomain Script v1.0 - mK        ##    
##                                    ##
########################################
"@

## Add Primary & Secondary IP's to your current Network Interface.

$val = Get-NetRoute | ? DestinationPrefix -eq '0.0.0.0/0' | Get-NetIPInterface | Where ConnectionState -eq 'Connected' |  Select ifindex -First 1 | ft -HideTableHeaders | out-string
Set-DNSClientServerAddress -interfaceIndex $val -ServerAddresses ("192.168.2.2","8.8.8.8")


## Will ask whether to change computer name or not , Then will add to an Organizational Unit in AD

$CompName = (Get-WmiObject Win32_OperatingSystem).CSName # Will get your current System Name
$NewCompName = Read-Host -Prompt "Your Current System Name is < '$CompName' > If you want to enter new name, Please enter or leave it blank (DEPT-USER eg: CICT-MK)"
$Domain = "villacollege.edu.mv" # Your Domain Name
$OU = "OU=COMPUTERS,DC=villacollege,DC=edu,DC=mv" # Your OU

if($newcompname){
    Add-Computer -DomainName $Domain -OUPath $OU -NewName $NewCompName -Restart
}else{
    Add-Computer -DomainName $Domain -OUPath $OU -Restart
}


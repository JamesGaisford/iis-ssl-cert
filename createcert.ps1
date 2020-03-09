cls

Write-Host ""
            "*********************** PLEASE PROVIDE THE FOLLOWING INFORMATION ****************************"
            " You are about to create a certificate for an IIS Site. Please provide the following "

$iisSiteName = Read-Host "IIS Site Name "
if([string]::IsNullOrWhiteSpace($iisSiteName)){
    Write-Error "Exiting: You must provide an IIS Site Name"
    exit
}

$iisSiteBinding = Read-Host "Binding Name - eg 'local.yoursite.com'"

if([string]::IsNullOrWhiteSpace($iisSiteBinding)){
    Write-Error "Exiting: You must provide an IIS Binding"
    exit
}

$TargetCertDir = 'c:\local-certs'
$TargetExport = $TargetCertDir + '\' + $iisSiteBinding + '.p7b'
$certStorePath = 'cert:\localmachine\my'

$newCert = New-SelfSignedCertificate -DnsName $iisSiteBinding -FriendlyName $iisSiteBinding -CertStoreLocation $certStorePath

$newCertPath = $certStorePath + '\' + $newCert.Thumbprint
$certFromStore = Get-ChildItem -Path $newCertPath

if(!(Test-Path -Path $TargetCertDir )){
    New-Item -ItemType directory -Path $TargetCertDir
}

Export-Certificate -Cert $newCertPath  -FilePath $TargetExport -Type p7b 

Remove-IISSiteBinding -Name $iisSiteName -BindingInformation "*:443:$iisSiteBinding" -Protocol https -RemoveConfigOnly

New-IISSiteBinding -Name $iisSiteName -BindingInformation "*:443:$iisSiteBinding" -CertStoreLocation $certStorePath -Protocol https -CertificateThumbPrint $newCert.Thumbprint -Force

Write-Host  ""
            ""
            "************************ PLEASE READ *********************************************" 
            ""
            " This script has ... "
            " - created a certificate for " + $iisSiteBinding 
            " - saved it to disk at " + $TargetExport
            " - added it to your personal certificate store on this machine. "
            " - created HTTPS IIS bindings using the cert."
            ""
            "************************NOW YOU NEED TO *****************************************"
            "*                                                                               *"
            "* Tell your browser to trust the new cert by                                    *"
            "*                                                                               *"
            "* - Go to your browser settings                                                 *"
            "* -- In Edge navigate to edge://settings/?search=certificates                   *"
            "* -- Click Manage Certificates                                                  *" 
            "* -- Click Import in the dialog that opens                                      *"
            "* -- At the Certificate Store screen of the dialog                              *"
            "* --- Select 'Place all certificates in the following store'                    *"
            "* --- Click Browse and select 'Trusted Root Certification Authorities'          *"
            "* -- Click Finish                                                               *"
            "*                                                                               *"
            "*********************************************************************************"
            #ii $TargetExport



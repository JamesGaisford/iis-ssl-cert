# iis-ssl-cert
Powershell script to create and SSL cert and bindings for an IIS website

## Overview
This is a script to speed up the creation of SSL certificates when developing on Windows using IIS.

This script will....
- create an SSL certificate
- save it to disk
- add it to your personal certificate store on your local machine
- create HTTPS bindings in IIS using the certificate

### Parameters
When you run this script, you will be asked for two parameters
1. IIS Site Name
  The name of the site in IIS to which you are adding the certificate and bindings
2. Binding Name 
  The name of the binding you want to add to your local site - eg `local.mysite.com`

### Running the script
1. Clone this repo.
2. Open powershell and navigate to the directory you just cloned this to.
3. type `./create-cert.ps1`
4. You will be prompted for the parameters above
5. Once the script completes it displays some additional instructions which you must complete in order to finish installation of the cert.

### Your job
You need to tell your browser to trust the new cert by 

* Go to your browser settings 
  * In Edge navigate to `edge://settings/?search=certificates`
  * Click Manage Certificates
  * Click Import in the dialog that opens
  * At the Certificate Store screen of the dialog
    * Select 'Place all certificates in the following store'
    * Click Browse and select 'Trusted Root Certification Authorities' 
  * Click Finish

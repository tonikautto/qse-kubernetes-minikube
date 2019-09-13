# Deploy Qlik Sense for Kubernetes on local Minikube

This project simplifies the deployment of Qlik Sense Enterprise for Kubernetes (QSEoK) on local Minikube. This can be used for testing, but should not be applied in production environment. 

This ReadMe focuses on deployment in Windows, for MacOS guideline see [README-MacOS](README-MacOS.md)

`values.yaml` contains the deployment configuration for QSEoK. Depending on your custom configuration this file may contain secret details e.g. related to authentication setup. Caution is advised on shairng your custom configuration file to others. 

Scripts and details are based on default deployment of Qlik Sense April 2019 as described in related Qlik Help pages.

* [Qlik Sense Help](https://help.qlik.com/en-US/sense/Content/Sense_Helpsites/Home.htm)
* [Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Deploying-Qlik-Sense-multi-cloud-Efe.htm)
* [Prepare install](https://help.qlik.com/en-US/sense/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Preparing-Qlik-Sense-multi-cloud-Efe.htm)
* [Using Minikube](https://help.qlik.com/en-US/sense/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/using-minikube-qseok.htm)
* [Installing Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Installing-Qlik-Sense-multi-cloud-Efe.htm)

## Pre-requisites

- Qlik Sense Enterprise signed license key
- Internet access

## Before you begin 

Check that virtualization is enabled on your client machine. 

Run `systeminfo` command in Powershell to confirm if virtualization is enabled on your computer. 
If you see the following output, virtualization is supported on Windows.
If you do not get below details, please enable virtualization (VT-x feature) in BIOS settings. 
```
Hyper-V Requirements: VM Monitor Mode Extensions: Yes
                        Virtualization Enabled In Firmware: Yes
                        Second Level Address Translation: Yes
                        Data Execution Prevention Available: Yes
```                          

## Install Tools

Tools only need to be installed once, and only if not already installed. 
* Virtualbox
* Minikube
* Kubectl
* Helm

The attached script [0-Install-Tools-Chocolatey-Win.ps1](0-Install-Tools-Chocolatey-Win.ps1) uses [Chocolatey package manager for Windows](https://chocolatey.org/) to install all the required tools. 

Either install manually following below commands _OR_ run attached [0-Install-Tools-Chocolatey-Win.ps1](0-Install-Tools-Chocolatey-Win.ps1)
        
1. Open PowerShell terminal as Administrator 
1. Run [0-Install-Tools-Chocolatey-Win.ps1](0-Install-Tools-Chocolatey-Win.ps1)
1. Open Virtualbox GUI to confirm it was installed correctly 
1. Interact with tools in Powershell temrinal to validate they were installed
    - Minikube `minikube --help`
    - Kubectl `kubectl --help`
    - Helm `helm --help`

## Deploy Qlik Sense on Kubernetes on Minikube

5. Open PowerShell terminal
1. Run deployment script [1-Deploy-Minikube-Win.ps1](1-Deploy-Minikube-Win.ps1)
1. Get Minikube IP address 
<br/>`minikube ip`
1. Update local host file to enable resolving Minikube IP to *elastic.example*.  
<br/>Windows hostfile in *C:\Windows\System32\drivers\etc* to include row with IP from previous refering to *elastic.example*  <br /> `<IP ADDRESS> elastic.example` 

## Access Qlik Sense

9. Browse to console https://elastic.example:32443/console/
1. Apply license
1. Browse to Hub https://elastic.example:32443
    <br/>User: harley@qlik.example
    <br/>Pwd: Password1!

## Remove deployment

12. Terminated and remove minikube instance <br /> `minikube delete`

## Troubleshooting

*Error: validation failed: error validating "": error validating data: unknown object type "nil" in Secret.data.redis-password`*

This error appears during Qlik package installation, when using Helm 2.14. Issue can be reoslve by downgrading to Helm 2.13.1. <br />

`choco install kubernetes-helm --version 2.13.1 --yes --force`

## License

This project is provided "AS IS", without any warranty, under the MIT License - see the [LICENSE](LICENSE) file for details


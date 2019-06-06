# Deploy Qlik Sense for Kubernetes on local Minikube

This project simplifies the deployment of Qlik Sense Enterprise for Kubernetes (QSEoK) on local Minikube. This can be used for testing, but should not be applied in production environment. 

Scripts and details are based on default deployment of Qlik Sense April 2019 in a Windows client machine.

## Qlik Sense Help Reference 

* [Qlik Sense Help](https://help.qlik.com/en-US/sense/Content/Sense_Helpsites/Home.htm)
* [Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Deploying-Qlik-Sense-multi-cloud-Efe.htm)
* [Prepare install](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Preparing-Qlik-Sense-multi-cloud-Efe.htm)
* [Using Minikube](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/using-minikube-qseok.htm)
* [Installing Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Installing-Qlik-Sense-multi-cloud-Efe.htm)

## Pre-requisites

- Qlik Sense Enterprise signed license key
- Windows client machine
- Tools to run and envrionemtn 
    - Virtualbox
    - Minikube
    - Kubectl
    - Helm

## Install Tools
Tools only need to be installed once, and only if not already installed. Below references use [Chocolatey package manager for Windows](https://chocolatey.org/) as an easy way to silently install the required tools. 

1. Open PowerShell terminal as Administrator 
1. Install Chocolatey package manager
    ```
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    ```
1. Install tool packages from Chocolatey
    - Virtualbox `choco install virtualbox --yes`
    - Minikube `choco install minikube --yes`
    - Kubectl `choco install kubernetes-cli --yes`
    - Helm `choco install kubernetes-helm --yes` 
1. Restart computer to complete installations

## Deploy Qlik Sense on Kubernetes on Minikube

1. Open Powershell terminal
1. Run `1-Deploy-Minikube.ps1` to deploy QSEoK on Minikube
    - Runs Minikube VM in Virtual box
    - Installs and configures QSE on Kubernetes
1. Run `kubectl get pods` until all pods are running. <br/>Note, this takes several minutes. 
1. Get Minikube IP address `minikube ip`
1. Update Windows hostfile in *C:\Windows\System32\drivers\etc* to include row with IP from previous refering to *elastic.example*  <br /> `<IP ADDRESS> elastic.example` 
1. Browse to console https://elastic.example:32443/console/
1. Apply license
1. Browse to Hub https://elastic.example:32443
    <br/>User: harley@qlik.example
    <br/>Pwd: Password1!

## Remove deployment

1. Terminated and remove minikube instance <br /> `minikube delete`

## Troubleshooting

*Error: validation failed: error validating "": error validating data: unknown object type "nil" in Secret.data.redis-password`*

This error appears during Qlik package installation, when using Helm 2.14. Issue can be reoslve by downgrading to Helm 12.3.1. <br />

`choco install kubernetes-helm --version 2.13.1 --yes --force`

## License

This project is provided "AS IS", without any warranty, under the MIT License - see the [LICENSE](LICENSE) file for details


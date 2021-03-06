# Deploy Qlik Sense for Kubernetes on local Minikube

This project simplifies the deployment of Qlik Sense Enterprise for Kubernetes (QSEoK) on local Minikube. This can be used for testing, but should not be applied in production environment. 

This ReadMe focuses on deployment in MacOS, for Windows guideline see [README](README.md)

`values.yaml` contains the deployment configuration for QSEoK. Depending on your custom configuration this file may contain secret details e.g. related to authentication setup. Caution is advised on shairng your custom configuration file to others. 

Scripts and details are based on default deployment of Qlik Sense April 2019 as described in related Qlik Help pages.

* [Qlik Sense Help](https://help.qlik.com/en-US/sense/Content/Sense_Helpsites/Home.htm)
* [Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Deploying-Qlik-Sense-multi-cloud-Efe.htm)
* [Prepare install](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Preparing-Qlik-Sense-multi-cloud-Efe.htm)
* [Using Minikube](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/using-minikube-qseok.htm)
* [Installing Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Installing-Qlik-Sense-multi-cloud-Efe.htm)

## Pre-requisites

- Qlik Sense Enterprise signed license key
- Internet access

## Before you begin 

Check that virtualization is enabled on your client machine. 
Run the following command in terminal to confirm if virtualization is supported on macOS.
<br/>`sysctl -a | grep machdep.cpu.features`
<br/>If you see VMX in the output, the VT-x feature is supported on your OS.

## Install Tools
Tools only need to be installed once, and only if not already installed. 

Below references use [Homebrew package manager for MacOS](https://brew.sh/). 

1. Open Terminal
1. Install tool packages 
    - Virtualbox: `brew cask install virtualbox`
    - Minikube: `brew cask install minikube`
    - Kubectl: `brew install kubernetes-cli`
    - Helm: `brew install kubernetes-helm`
1. Open Virtualbox GUI to confirm it was installed correctly 
1. Open tools help to confirm successful install
    - Minikube `minikube --help`
    - Kubectl `kubectl --help`
    - Helm `helm --help`

## Deploy Qlik Sense on Kubernetes on Minikube

1. Open Terminal 
1. Start Minikube 
<br/>`minikube start --memory 8000 --cpus=4`
<br/>Note: Set the kube size so it fits within available resources
1. Configure Kubesctl to target Minikube 
<br/>`kubectl config set-cluster minikube`
1. Add Qlik's chart repository to Helm 
<br/>`helm repo add qlik https://qlik.bintray.com/stable`
1. Initiate Helm for deployment into Kubernetes. Helm Tiller pod is added to the Kubernetes cluster first.
 <br/>`helm init --wait`
1. Install custom resource definitions used by dynamic engines
<br/>`helm install --name qliksense-init qlik/qliksense-init`
1. Install the Qlik Sense packages
<br/>`helm install -n qliksense qlik/qliksense -f values.yaml`
1. List pods to see their current status
<br/>`kubectl get pods`
1. Repeat previous step until all pods (besides engine) are running. 
<br/>Note, this takes several minutes. 
1. Get Minikube IP address 
<br/>`minikube ip`
1. Update local host file to enable resolving Minikube IP to *elastic.example*.  
## Access Qlik Sense

1. Browse to console https://elastic.example:32443/console/
1. Apply license
1. Browse to Hub https://elastic.example:32443
    <br/>User: harley@qlik.example
    <br/>Pwd: Password1!

## Remove deployment

1. Terminated and remove minikube instance <br /> `minikube delete`

## Troubleshooting

*Error: validation failed: error validating "": error validating data: unknown object type "nil" in Secret.data.redis-password`*

This error appears during Qlik package installation, when using Helm 2.14. Issue can be reoslve by downgrading to Helm 2.13.1. <br />

`choco install kubernetes-helm --version 2.13.1 --yes --force`

## License

This project is provided "AS IS", without any warranty, under the MIT License - see the [LICENSE](LICENSE) file for details


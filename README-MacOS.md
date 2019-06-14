# Deploy Qlik Sense for Kubernetes on local Minikube

This project simplifies the deployment of Qlik Sense Enterprise for Kubernetes (QSEoK) on local Minikube. This can be used for testing, but should not be applied in production environment. 

Scripts and details are based on default deployment of Qlik Sense April 2019 as described in related Qlik Help pages.

* [Qlik Sense Help](https://help.qlik.com/en-US/sense/Content/Sense_Helpsites/Home.htm)
* [Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Deploying-Qlik-Sense-multi-cloud-Efe.htm)
* [Prepare install](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Preparing-Qlik-Sense-multi-cloud-Efe.htm)
* [Using Minikube](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/using-minikube-qseok.htm)
* [Installing Qlik Sense Enterprise on Kubernetes](https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Installing-Qlik-Sense-multi-cloud-Efe.htm)

## Pre-requisites

- Qlik Sense Enterprise signed license key
- [Homebrew](https://brew.sh/) package manager
- Tools to run and envrionment 
    - Virtualbox
    - Minikube
    - Kubectl
    - Helm
- Internet access

## Before you begin 

Check that virtualization is enabled on your client machine. 

Run the following command in terminal to confirm if virtualization is supported on macOS.
<br/>`sysctl -a | grep machdep.cpu.features`
<br/>If you see VMX in the output, the VT-x feature is supported on your OS.

## Install Tools
Tools only need to be installed once, and only if not already installed. 

Below references use [Homebrew package manager for MacOS](https://brew.sh/). 

1. Open terminal
1. Install tool packages 
    - Virtualbox: `brew cask install virtualbox`
    - Minikube: `brew cask install minikube`
    - Kubectl: `brew install kubernetes-cli`
    - Helm: `brew install kubernetes-helm`
1. Open Virtualbox GUI to confirm it was instaleld correctly 
1. Open tools help to confirm successful install
    - Minikube `minikube --help`
    - Kubectl `kubectl --help`
    - Helm `helm --help`

## Deploy Qlik Sense on Kubernetes on Minikube

1. Open Termiinal 
1. Start Minikube 
<br/>Note: Set the kube size so it fits within available resources
<br/>`minikube start --memory 8000 --cpus=4`
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
1. Edit host file and add entry for `<IP ADDRESS> elastic.example` to enable resolving *elastic.example*.
<br/>`sudo nano /etc/hosts`
1. Browse to console https://elastic.example:32443/console/
1. Apply license
1. Browse to Hub https://elastic.example:32443
    <br/>User: harley@qlik.example
    <br/>Pwd: Password1!

## Remove deployment

1. Terminated and remove minikube instance 
<br /> `minikube delete`

## License

This project is provided "AS IS", without any warranty, under the MIT License - see the [LICENSE](LICENSE) file for details


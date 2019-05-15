# Reference: https://help.qlik.com/en-US/sense/April2019/Subsystems/PlanningQlikSenseDeployments/Content/Sense_Deployment/Preparing-Qlik-Sense-multi-cloud-Efe.htm
#minikube delete

# Start minikube 
minikube start --memory 8000 --cpus=2

# Verify that kubectl is pointing to minikube
# TBD: Validate minikube, and break if not
kubectl config current-context

# Run the following command to add Qlik’s helm chart repository to Helm. This is where Qlik Sense is pulled from:
helm repo add qlik https://qlik.bintray.com/stable

# Use the following command to get a list of all configured repositories and verify that the Qlik helm chart repository was successfully added:
helm repo list

# use helm to deploy into Kubernetes, the helm Tiller pod is added to the Kubernetes cluster first.
helm init --wait

# Install custom resource definitions used by dynamic engines
helm install --name qliksense-init qlik/qliksense-init

# Install the Qlik Sense package
helm install -n qliksense qlik/qliksense -f minikube-values.yaml

$pods = kubectl get pods
# refresh pod status every minute
while (1) {kubectl get pods; Start-Sleep 60; Clear-Host }

# Get deploymetn ip
minikube ip

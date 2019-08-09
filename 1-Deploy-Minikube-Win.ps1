# Start minikube with 2 CPU and 8GB RAM
minikube start --memory 8000 --cpus=4

# Force Kubectl to poin to minikube
kubectl config set-cluster minikube

# Run the following command to add Qlik’s helm chart repository to Helm. This is where Qlik Sense is pulled from:
helm repo add qlik https://qlik.bintray.com/stable

# use helm to deploy into Kubernetes, the helm Tiller pod is added to the Kubernetes cluster first.
helm init --wait

# Install custom resource definitions used by dynamic engines
helm install --name qliksense-init qlik/qliksense-init

# Install the Qlik Sense package
helm install -n qliksense qlik/qliksense -f values.yaml

# List pods
kubectl get pods

# Print IP
minikube ip
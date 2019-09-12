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

# Wait until all pods are running
$pods_total_count = (kubectl get pods | Measure-Object).Count

do {
    $pods_running_count = ((kubectl get pods | Select-String -Pattern 'Running') | Measure-Object).Count
    $pods_started_progress = [Math]::Floor(($pods_running_count / $pods_total_count)*100)
    Write-Progress -Activity "Starting Kubernetes pods for Qlik Sense Enterprise" -Status "$pods_running_count of $pods_total_count ($pods_started_progress%) pods are in Running state:" -PercentComplete $pods_started_progress
} while ($pods_started_progress -lt 100)

# Print IP
Write-Host "Link Minikube IP $(minikube ip) with elastic.example in Windows host file" -ForegroundColor Green
Write-Host "C:\Windows\System32\drivers\etc\hosts" -ForegroundColor Green
Write-Host "$(minikube ip)  elastic.example" -ForegroundColor Green
 

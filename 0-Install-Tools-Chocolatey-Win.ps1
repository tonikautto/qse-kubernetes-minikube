#Requires -RunAsAdministrator

# Virtual box
choco install virtualbox --force --yes

# Minikube
choco install minikube --force --yes

# Kubectl
choco install kubernetes-cli --force --yes

# Helm
# choco install kubernetes-helm --yes
# Workaround due to issues with Helm 2.14, https://support.qlik.com/articles/000075385
choco install kubernetes-helm --version 2.13.1 --yes --force

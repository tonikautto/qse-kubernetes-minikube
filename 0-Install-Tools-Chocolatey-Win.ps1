#Requires -RunAsAdministrator

# Install Chocolatey package manager
# Reference https://chocolatey.org/install
Set-ExecutionPolicy Bypass -Scope Process -Force 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Virtual box
choco install virtualbox --yes

# Minikube
choco install minikube --yes

# Kubectl
choco install kubernetes-cli --yes

# Helm
#choco install kubernetes-helm --yes
# Workaround due to issues with Helm 2.14, https://support.qlik.com/articles/000075385
choco install kubernetes-helm --version 2.13.1 --yes --force


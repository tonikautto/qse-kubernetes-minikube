#Requires -RunAsAdministrator

# Install Chocolatey package manager
# Reference https://chocolatey.org/install
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Virtual box
choco install virtualbox --yes

# Minikube
choco install minikube --yes

# Kubectl
choco install kubernetes-cli --yes

# Helm
choco install kubernetes-helm --yes

# terraform-linux-vmware
Provision a Linux server in On Premise VMware environment with iPerf3 installed.

## Requirements
- A server template ready in the target vSphere environment
- terraform 0.11 or later
- PowerShell (Core)

## Create a new branch
Ceate a branch for your deployment.
```
git branch branchName
```
Switch to the newly created branch.
```
git checkout branchName
```

## Deploy or update a new server
Confirm you are **NOT** using the **Master** branch.

Modify default values for variables in variables.tf file. Do not change values written in **FULL UPCASE**.


```powershell
.\tf-deploy.ps1 -vCenter [vCenterServerName] -PrivateFilePath "C:/file/path/to/keyfile"
```
Type in credential for vSphere access.

## Destroy 
```powershell
.\tf-destroy.ps1 -vCenter [vCenterServerName] -PrivateFilePath "C:/file/path/to/keyfile"
```
Type in credential for vSphere access.


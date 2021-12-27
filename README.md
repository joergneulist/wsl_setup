# Setup Arch Linux on WSL
Setup WSL2 especially with respect to jupyter lab in virtual environments.

## Step 1: Enable WSL2 and get the kernel update
* (Admin PowerShell) `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
* `wsl --set-default-version 2` to enable WSL2 - if it asks for a kernel update, install that

## Step 2:
Install Linux distro (Arch: https://github.com/yuk7/ArchWSL/):
* Execute `arch.exe`

## Step 3: Copy files from this repo and set up
Look into `setup_wsl.sh` and adapt the settings where necessary, then execute it.

## Step 4: Finishing touches
* Outside WSL: run `arch.exe config --default-user joerg`, or whoever you want to be
* Start WSL
* Create python virtual environments (jupyter kernels will be created automatically), eg:
  * venv_create py39 -p python3.9
  * venv_create default
  
## Step 5: Configure host
* Install and setup vcxsrv to enable X applications

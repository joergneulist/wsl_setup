# Setup Arch Linux on WSL
Setup WSL2 especially with respect to jupyter lab in virtual environments.

## Step 1: Enable WSL2 and get the kernel update
* (Admin PowerShell) `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
* `wsl --set-default-version 2` to enable WSL2 - if it asks for a kernel update, install that

## Step 2:
Install Linux distro (Arch: https://github.com/yuk7/ArchWSL/):
* Execute `arch.exe`

## Step 3: Set up Linux
* Download or check out this repo
* Look into `config` and adapt the settings where necessary
* Execute 1_setup_root.sh and wait till it changes into your new user account
* Execute 2_setup_user.sh and wait until it is done

## Step 4: Copy files from this repo
* Copy the .-files to your user home directory: `cp -a .env.d .jupyter .zshenv ~`
* Exit WSL for now (say `exit` twice)

## Step 5: Finishing touches
* Outside WSL: run `arch.exe config --default-user joerg`, or whoever you want to be
* Start WSL
* Create python virtual environments (jupyter kernels will be created automatically), eg:
  * venv_create py39 -p python3.9
  * venv_create default
  
## Step 6: Configure host
* Install and setup vcxsrv to enable X applications
* You can create shortcuts from Windows into WSL by running `wsl -- command`
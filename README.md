# Setup Ubuntu Linux on WSL
Setup WSL2 especially with respect to jupyter lab in virtual environments.

## Step 1: Enable WSL2 and get the kernel update
* (Admin PowerShell) `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
* `wsl --set-default-version 2` to enable WSL2 - if it asks for a kernel update, install that

## Step 2: Install Linux distro
* `wsl --install ubuntu`
* Follow the setup, it drops you right on the new system prompt

## Step 3: Set up Linux
* `git clone https://github.com/joergneulist/wsl_setup.git`
* Look into `wsl_setup/config` and adapt the settings where necessary
* Execute `install.sh` and wait until it is done
* This will update the system, install a very few nice tools, plus oh-my-zsh, and setup a poetry env with jupyter lab in it

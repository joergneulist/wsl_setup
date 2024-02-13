# Setup Ubuntu Linux on WSL
Setup WSL2 especially with respect to jupyter lab in virtual environments.

## Step 1: Admin Powershell
```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
wsl --set-default-version 2
wsl --install ubuntu
```

Follow the setup, it drops you right on the new linux system prompt.

## Step 2: Set up Linux
```
git clone https://github.com/joergneulist/wsl_setup.git
```

Examine `wsl_setup/config` and adapt the settings where necessary.

```
wsl_setup/install.sh
```

This script will update the system, install a very few nice tools, plus oh-my-zsh, and setup a poetry env with jupyter lab in it. After it's done, you should exit WSL and launch it again to activate the new shell.

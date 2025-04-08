# Configure SSH-Agent with KeePassXC

Short instruction on how to enable SSH-Agent on Windows / WSL using KeePassXC.

# Setup

`npiperelay.exe` is still needed on the Windows side and socat on WSL to work.

## Install npiperelay

Install it via [Chocolatey](https://chocolatey.org/) from PowerShell:
`choco install npiperelay`

## Install socat (WSL)

Install "socat" via apt:
`sudo apt install socat`

## Helper Script

Download the SSH-Agent helper Script:
wget 

 - `wget https://github.com/kxaithefraud/lab/blob/main/Notes/SSH-Agent-KeePassXC/wsl-ssh-agent-script`
 - `mkdir -P ~/.local/bin`
 - `mv wsl-ssh-agent-script ~/.local/bin`
 - `chmod +x ~/.local/bin/wsl-ssh-agent-script`

Start the helper Script

 - `${HOME}/.local/bin/wsl-ssh-agent-script start`
 - `export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock`

## Done :)

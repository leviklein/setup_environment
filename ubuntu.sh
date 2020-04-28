#!/usr/bin/env bash

source ./common.sh

sudo apt update

#utilities
sudo apt install \
  vim \
  curl \
  python3-pip \
  -y

# vscode
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code -y
code --install-extension shan.code-settings-sync

#zsh
sudo apt install zsh -y
zsh --version
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#zsh theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

#ansible and config files
sudo apt install ansible -y
ansible-playbook ./playbook.yml

#git
git config --global user.email "levikleinm@gmail.com"
git config --global user.name "Levi Klein Marifosque"

#docker
sudo apt-get install \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
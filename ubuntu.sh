#!/usr/bin/env bash
set -e

function install_utilities()
{
  sudo apt install \
    vim \
    curl \
    python3-pip \
    -y
}

function install_ansible()
{
  sudo apt install ansible -y
}

function install_zsh()
{
  #installs Ansible as well

  sudo apt install zsh -y
  zsh --version
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  #zsh theme
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

  install_ansible
  ansible-playbook ./playbook.yml
}

function edit_git_config()
{
  git config --global user.email "levikleinm@gmail.com"
  git config --global user.name "Levi Klein Marifosque"
}

function install_vscode()
{
  sudo apt install software-properties-common apt-transport-https wget -y
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt update
  sudo apt install code -y
  code --install-extension shan.code-settings-sync
}

function install_docker()
{
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
}

function main()
{
  source ./common.sh

  sudo apt update

  install_utilities
  install_zsh
  edit_git_config

  IS_WSL=`which explorer.exe`
  if [[ -n "$IS_WSL"  ]]; then
    echo "WSL"
  else
    install_vscode
    install_docker
  fi

  # post install
  ## set default shell to zsh
  sudo chsh -s $(which zsh)
  
  echo ""
  echo "Done!"
}

main
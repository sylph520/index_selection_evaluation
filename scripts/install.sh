#!/bin/bash

function reados()
{
    string=$(uname -rv)
    if [[ $string == *"Ubuntu"* || $string == *"Debian"* ]]; then
        echo 'debian'
    elif [[ $string == *"Darwin"* ]]; then
        echo 'darwin'
    fi
}

git submodule update --init --recursive

if [[ $(reados) == 'debian' ]]; then
    # https://github.com/ankane/dexter/blob/master/guides/Linux.md
    wget -qO- https://dl.packager.io/srv/pghero/dexter/key | sudo apt-key add -
    sudo wget -O /etc/apt/sources.list.d/dexter.list \
      https://dl.packager.io/srv/pghero/dexter/master/installer/ubuntu/18.04.repo
    sudo apt update
    sudo apt -y install dexter

    # https://github.com/gregrahn/tpcds-kit
    sudo apt -y install flex bison byacc
elif [[ $(reados) == 'darwin' ]]; then
    brew install python3

    brew install postgresql@12
    brew services start postgresql
    brew install ankane/brew/dexter
fi

pip3 install -r requirements.txt

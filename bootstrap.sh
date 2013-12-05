#!/bin/bash

sudp apt-get update
sudo apt-get install -y curl
# apt-get upgrade

\curl -sSL https://get.rvm.io | bash -s stable --ruby

sudo apt-get install -y libcurl3-dev

## 
cd /vagrant/

source ~/.bashrc
bundle install --path ~/.gem
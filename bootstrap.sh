#!/bin/bash

sudp apt-get update
sudo apt-get install -y curl
# apt-get upgrade

\curl -sSL https://get.rvm.io | bash -s stable --ruby

sudo apt-get install libcurl3-dev

## 
cd /vagrant/
bundle install --path ~/.gem
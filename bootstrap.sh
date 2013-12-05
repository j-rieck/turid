#!/bin/bash

sudp apt-get update
sudo apt-get install -y curl
# apt-get upgrade

\curl -sSL https://get.rvm.io | bash -s stable --ruby

sudo apt-get install -y libcurl3-dev

mkdir -p ~/Downloads/
cd ~/Downloads/

## Install Java
wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-i586.tar.gz"
tar xvzf jdk-7u45-linux-i586.tar.gz
sudo mkdir -p /usr/lib/jvm/
sudo mv jdk1.7.0_45 /usr/lib/jvm
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.7.0_45/jre/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.7.0_45/bin/javac" 1

## Install elastic search
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb
sudo dpkg -i elasticsearch-0.90.7.deb
sudo service elasticsearch start

## Cleanup
rm jdk-7u45-linux-i586.tar.gz
rm elasticsearch-0.90.7.deb


## 
cd /vagrant/
bundle install --path ~/.gem
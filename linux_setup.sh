#!/bin/bash
cd /tmp

# DEVELOPMENT
echo '=> DEVELOPMENT ENVIRONMENT';

# SET TIMEZONE
sudo dpkg-reconfigure tzdata

# Node.JS
echo ' -- Installing node.js';
sudo apt-get install python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

# MONGO DB
echo ' -- Installing MongoDB';
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo touch /etc/apt/sources.list.d/10gen.list
sudo sh -c "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'" >> /etc/apt/sources.list.d/10gen.list
sudo apt-get update
sudo apt-get install mongodb-10gen


## DESKTOP
echo '=> DESKTOP ENVIRONMENT';

# NAS
echo ' -- Setting up NAS';
sudo mkdir -p /media/NAS
sudo sh -c "echo '//192.168.1.176/NASData /media/NAS cifs user,uid=1000,rw,suid,credentials=/etc/credentials 0 0'" >> /etc/fstab

sudo touch /etc/credentials
sudo sh -c "echo 'username=XXXXXX'" >> /etc/credentials
sudo sh -c "echo 'password=XXXXXX'" >> /etc/credentials
sudo sh -c "echo 'domain=XXXXXX'" >> /etc/credentials
mount -a

# APPS
echo ' -- Setting up Apps';
sudo apt-get install vlc
sudo apt-get install docky
sudo apt-get install synaptic
sudo apt-get install unity-tweak-tool
sudo apt-get install git

# CHROME
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

# Sublime Text 2
sudo add-apt-repository ppa:webupd8team/sublime-text-2;
sudo apt-get update && sudo apt-get install sublime-text;


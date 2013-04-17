## Node.JS
sudo apt-get install python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

## MONGO DB
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/10gen.list
sudo apt-get update
sudo apt-get install mongodb-10gen

## NAS
sudo mkdir -p /media/NAS
sudo echo '//192.168.1.176/NASData /media/NAS cifs user,uid=1000,rw,suid,credentials=/etc/credentials 0 0' > /etc/fstab
sudo mount -a


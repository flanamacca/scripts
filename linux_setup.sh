#!/bin/bash
#set -x
# Linux Server Setup Script

# Variables
current_user=$(whoami)
cmd_prefix=""
log_file="$railsready_path/install.log"

#if [ $(id -u) -ne 0 ]; then
	#echo "Please run this script with administrative privileges"
	#exit 2
#fi

setupUser()
{
	# Setup a main user
	if false
	then
		if [ $(id -u) -eq 0 ]; then
			read -p "Enter username : " username
			read -s -p "Enter password : " password
			egrep "^$username" /etc/passwd >/dev/null
			if [ $? -eq 0 ]; then
				echo "$username exists!"
				exit 1
			else
				pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
				useradd -m -p $pass $username
				[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
			fi
		else
			echo "Only root may add a user to the system"
			#exit 2
		fi
	fi
}

setupMySQL()
{
	echo "cool";
}


setupMongoDB()
{
	# Setup MongoDB
	echo "=> Installing MongoDB";
	sources_file="/etc/apt/sources.list";
	mongodb_package="mongodb-10gen";
	mongodb_source="deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen";
	#deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen;
	
	which $mongodb_package >/dev/null
	if [ $? -ne 0 ]; then
		egrep "^$mongodb_source" $sources_file >/dev/null
		if [ $? -eq 0 ]; then
			# code if found
			echo "MongoDB Sources Present"
		else
			# Add MongoDB Sources
			sudo sh -c "echo \"## MongoDB\" >> $sources_file"
			sudo sh -c "echo \"$mongodb_source\" >> $sources_file"
			echo "Adding MongoDB Sources"
			#echo "## MongoDB" >> $sources_file
			#echo "$mongodb_source" >> $sources_file
			sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10			
			sudo apt-get update
		fi
		#sudo apt-get install $mongodb_package
	else
		echo "  *** MongoDB Already Installed"
	fi
}

setupNginX()
{
	# Setup NginxX
	echo "=> Installing NginX"
	sudo apt-get -y install nginx
}

# Installs RVM, Ruby, Rails
setupRubyOnRails()
{
	ruby_version="1.9.3-p125";
	echo "Removing Local RVM Files";
	sudo rm -rf /usr/local/rvm/
	rm -rf ~/.rvm/	
	
	# Setup Ruby with RVM
	echo -e "=> Installing RVM"
	linux_ver=$(uname -r);
	sudo apt-get -y install build-essential libtool linux-headers-$linux_ver --force-yes;
	sudo apt-get -y install curl build-essential libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion --force-yes;
	#curl -L get.rvm.io | bash -s stable --ruby --rails ::::: This seems fucked
	bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
	
	# Reload the shell params
	source ~/.rvm/scripts/rvm
	#type rvm | head -1
	#rvm requirements
	
	echo " * Installing  readline, libyaml, zlib"
	rvm pkg install readline
	rvm pkg install libyaml	
	rvm pkg install zlib
	rvm pkg install openssl
	
	echo " * Installing Ruby-$ruby_version";
	rvm install ruby-$ruby_version
	rvm --default use ruby-$ruby_version
	
	echo " * Installing Bundler/Rails";
	gem update --no-ri --no-rdoc
	gem install bundler rails --no-ri --no-rdoc		
	
	echo " **** Software Versions ****"
	rvm -v
	ruby -v
	rails -v
	
}

setupNodeJS()
{
	git clone https://github.com/joyent/node.git
	cd node
	 
	# 'git tag' shows all available versions: select the latest stable.
	git checkout v0.6.8
	 
	# Configure seems not to find libssl by default so we give it an explicit pointer.
	# Optionally: you can isolate node by adding --prefix=/opt/node
	./configure --openssl-libpath=/usr/lib/ssl
	make
	make test
	sudo make install
	node -v # it's alive!
	 
	# Luck us: NPM is packaged with Node.js source so this is now installed too
	# curl http://npmjs.org/install.sh | sudo sh
	npm -v # it's alive!
}



#setupNginX
#setupMongoDB
#setupRubyOnRails
setupNodeJS

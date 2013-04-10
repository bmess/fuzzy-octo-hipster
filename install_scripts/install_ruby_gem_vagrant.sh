#!/bin/bash

# Keeping it simple so I can keep it lazy

# Install gem
sudo apt-get install gem ruby-dev

# Now *in gem*, install vagrant
if [ -f ./vagrant_x86_64.deb ];
then
    echo "file exists, trying to install now"
    sudo dpkg --install vagrant_x86_64.deb
else 
    echo "Trying to download x86_64 version to install..."
    wget http://files.vagrantup.com/packages/64e360814c3ad960d810456add977fd4c7d47ce6/vagrant_x86_64.deb
    sudo dpkg --install vagrant_x86_64.deb
fi

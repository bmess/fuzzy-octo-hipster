#!/bin/bash

# Keeping it simple.  We're going to check the architecture of the machine and
# download the proper version of the vagrant binary.

# Install gem
sudo apt-get install gem ruby-dev

if [ $(uname -m) == 'x86_64' ];
then
    echo "64 bit detected, now installing 64-bit vbox"
    # Now *in gem*, install vagrant
    if [ -f ./vagrant_1.3.1_x86_64.deb ];
    then
        echo "file exists, trying to install now"
        sudo dpkg --install vagrant_1.3.1_x86_64.deb
    else
        echo "Trying to download x86_64 version to install..."
        wget http://files.vagrantup.com/packages/b12c7e8814171c1295ef82416ffe51e8a168a244/vagrant_1.3.1_x86_64.deb
        sudo dpkg --install vagrant_1.3.1_x86_64.deb
    fi
else
    echo "32 bit detected, now installing 32-bit vbox"
    # Now *in gem*, install vagrant
    if [ -f ./vagrant_1.3.1_i686.deb ];
    then
        echo "file exists, trying to install now"
        sudo dpkg --install vagrant_1.3.1_i686.deb
    else
        echo "Trying to download i686 version to install..."
        wget http://files.vagrantup.com/packages/b12c7e8814171c1295ef82416ffe51e8a168a244/vagrant_1.3.1_i686.deb
        sudo dpkg --install vagrant_1.3.1_i686.deb
    fi
fi

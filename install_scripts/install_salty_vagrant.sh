#!/bin/bash

# This will install as your working user, into $HOME/.vagrant 
# Don't do it as root

cd ..

vagrant plugin install vagrant-salt

vagrant box add precise64 http://files.vagrantup.com/precise64.box


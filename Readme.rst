==============================================
Masterless SaltStack Minion with Salty Vagrant
==============================================

Before You Begin
================

All of this was tried on *Ubuntu Desktop 12.10*.  There's an expectation that 
the package names may change between different distributions.  Our goal is to 
install the bare minimum through packages, and have the newest versions of both 
vagrant & salty vagrant from their respective online repos.

We'll need the following to continue:
    * `Virtualbox <http://virtualbox.org>`_ (I'm using 4.2.10)
    * ruby gem 
    * `Salt Stack <http://saltstack.org>`_ 
    * `salty vagrant <https://github.com/saltstack/salty-vagrant>`_
        * salty vagrant `installation instructions <https://github.com/saltstack/salty-vagrant#masterless-quick-start>`_
    * A text editor of your choice. `Like this one <http://sublimetext.com>`_

Now repeat after me:
Salt Stack is amazing!  It's simply Python & YAML & Jinja2 (oh my!).  All 
magic within Salt Stack may be unlocked by reading the documentation.

Installing All the Goodies
==========================

Recap:  this is all done on *Ubuntu Desktop 12.10*.  I have every bit of faith 
that this will function on any other setup so long as you have Virtualbox and 
Ruby with a little bit of Python magic.

.. code-block:: console

    $ sudo apt-add-repository ppa:saltstack/salt
    You are about to add the following PPA to your system:
     Salt, the remote execution and configuration management tool.
     More info: https://launchpad.net/~saltstack/+archive/salt
    Press [ENTER] to continue or ctrl-c to cancel adding it
    
    gpg: keyring `/tmp/tmp5o3wtd/secring.gpg' created
    gpg: keyring `/tmp/tmp5o3wtd/pubring.gpg' created
    gpg: requesting key 0E27C0A6 from hkp server keyserver.ubuntu.com
    gpg: /tmp/tmp5o3wtd/trustdb.gpg: trustdb created
    gpg: key 0E27C0A6: public key "Launchpad PPA for Salt Stack" imported
    gpg: Total number processed: 1
    gpg:               imported: 1  (RSA: 1)
    OK
    
    # Dirty Ruby business 

    # Our OS's pkg manager will handle Gem
    $ sudo apt-get install gem

    # gem will handle getting the latest vagrant & salty-vagrant
    $ sudo gem install vagrant

`salty-vagrant` Install
-----------------------

Now you should know I could tell you how to install salty-vagrant, but following 
the easy to read instructions would be beneficial to everyone involved:

salty vagrant `installation instructions <https://github.com/saltstack/salty-vagrant#masterless-quick-start>`_

Copy/pasted from the link above:
#. Install Vagrant
#. Install Salty Vagrant (``vagrant plugin install vagrant-salt``)
#. Get the Ubuntu 12.04 base box: ``vagrant box add precise64 http://files.vagrantup.com/precise64.box``
#. Create/Update your ``Vagrantfile`` `Detailed in Configuration <https://github.com/saltstack/salty-vagrant#configuration>`_
#. Place your minion config in salt/minion 
#. Run vagrant up and you should be good to go.

You can try starting now, but you'll run into errors about the missing Salt Stack 
states.  Proceed to the next section to make this all **real**.

Fun and Excitement at 100 MPH
=============================

By now you should have the pieces in place to be able to begin a Vagrant-powered 
virtual machine.  Now we're going to move into the fun part:  automating the 
environment for our purposes.

We begin with the following:

.. code-block :: console

    .
    ├── Readme.rst
    └── Vagrantfile

Sounds like we need to build our Salt part.

Create the Salt state directory, and let's create the top file:

.. code-block :: console

    $ mkdir -p salt/roots/
    $ touch salt/root/top.sls

Now we can create a basic Salt state:

top.sls:

.. code-block :: yaml

    base:
      '*':
        - vim
      'role : dev':
        - match: grain
        - apache
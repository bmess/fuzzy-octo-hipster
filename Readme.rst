==============================================
Masterless SaltStack Minion with Salty Vagrant
==============================================

Before You Begin
================

All of this was tried on *Ubuntu Desktop 12.10*.  There's an expectation that 
the package names may change between different distributions.  Our goal is to 
install the bare minimum through packages, and have the newest versions of both 
vagrant & salty vagrant from their respective online repos.

There is an easy way and a hard way:

Easy Way
--------
This repo was designed as a shortcut to getting your feet wet with Salt Stack 
& *masterless-minions*.  You should be able to clone this repo, enter the 
directory and run the two installation scripts localted in ``install_scripts`` 

Hard Way
--------
Do this from scratch.  Follow the installation instructions from the readme on 
`the salty-vagrant github <https://github.com/saltstack/salty-vagrant>`_

Repeat After Me
---------------
Now repeat after me:
Salt Stack is amazing!  It's simply Python & YAML & Jinja2 (oh my!).  All 
magic within Salt Stack may be unlocked by reading `the documentation. <http://docs.saltstack.com>`_

The Hard Way
============

We'll need the following to continue:
    * `Virtualbox <http://virtualbox.org>`_ (I'm using 4.2.10)
    * Ruby gem 
    * `Salt Stack <http://saltstack.org>`_
    * `salty vagrant <https://github.com/saltstack/salty-vagrant>`_
        * salty vagrant `installation instructions <https://github.com/saltstack/salty-vagrant#masterless-quick-start>`_ (We'll install it from vagrant)
    * A text editor of your choice. `Like this one <http://sublimetext.com>`_


Recap:  this is all done on *Ubuntu Desktop 12.10*.  I have every bit of faith 
that this will function on any other setup so long as you have Virtualbox and 
Ruby with a little bit of Python magic.

Salt Stack is OS agnostic (with some caveats on Windows), and will run on Linux,
FreeBSD, and Windows.

Let's add Salt to our Ubuntu repo list.  If you have a non-Debian based system it's time to `look here instead <http://docs.saltstack.com/topics/installation/index.html>`_:

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

``salty-vagrant`` Install
-------------------------

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

    $ mkdir -p salt/roots/salt
    $ touch salt/roots/salt/top.sls

We should now have the following tree:

.. code-block :: console

 .
 ├── install_scripts
 │   ├── install_ruby_gem_vagrant.sh
 │   └── install_salty_vagrant.sh
 ├── Readme.rst
 ├── salt
 │   ├── minion
 │   └── roots
 │       └── salt
 │           ├── top.sls
 │           └── vim.sls
 ├── TODO.rst
 └── Vagrantfile



Now we can create a basic Salt *state*:

``top.sls``:

.. code-block :: yaml

    # 'base' is an environment, don't worry about it for now.
    base:

      # We're saying "everyone" ('*') should run the 'vim' salt state we're about to 
      # create.
      '*':
        - vim

      # Now we're stating all minions with the 'dev' role, run the following
      # salt state.  This state is called apache and it'll install the apache2 
      # HTTP server
      'role : dev':
        - match: grain
        - apache
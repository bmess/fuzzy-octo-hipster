==============================================
Masterless SaltStack Minion with Salty Vagrant
==============================================

Before You Begin
================

All of this was tried on *Ubuntu Desktop 12.10*.  There's an expectation that
the package names may change between different distributions.  Our goal is to
install the bare minimum through packages, and have the newest versions of both
vagrant & salty vagrant from their respective online repos.

Repeat After Me
---------------

Now repeat after me: SaltStack is amazing!  It's simply Python & YAML & Jinja2
(oh my!).  All magic within SaltStack may be unlocked by reading `the
documentation. <http://docs.saltstack.com>`_

The Easy Way
============

This repo was designed as a shortcut to getting your feet wet with SaltStack &
*masterless-minions*.

1. Clone the git repo:

.. code-block :: console

 user@host ~$ git clone git@github.com:bmess/fuzzy-octo-hipster
 user@host ~$ git clone git@github.com:/bmess/fuzzy-octo-hipster
 Cloning into 'fuzzy-octo-hipster'...
 remote: Counting objects: 84, done.
 remote: Compressing objects: 100% (66/66), done.
 remote: Total 84 (delta 27), reused 49 (delta 4)
 Receiving objects: 100% (84/84), 16.35 KiB, done.
 Resolving deltas: 100% (27/27), done.

2. Now let's install things.  If you don't trust the scripts asking for sudo,
   take a moment to review them and see it's just a few installation statements.

.. code-block :: console

 user@host ~$ cd install_scripts
 user@host~/fuzzy-octo-hipster/install_scripts$ ls
 install_ruby_gem_vagrant.sh  install_salty_vagrant.sh
 user@host~/fuzzy-octo-hipster/install_scripts$ ./install_ruby_gem_vagrant.sh
 user@host~/fuzzy-octo-hipster/install_scripts$ ./install_salty_vagrant.sh

3. Now it's time to startup the vagrant box!

.. code-block :: console

 user@host~/fuzzy-octo-hipster/$ vagrant up
 Bringing machine 'default' up with 'virtualbox' provider...
 [default] Importing base box 'precise64'...
 ...
 salt-call was not found.
 Bootstrapping Salt... (this may take a while)
 Salt successfully configured and installed!
 Calling state.highstate... (this may take a while)

4. Now enter the box:

.. code-block :: console

 user@host~/fuzzy-octo-hipster/$ vagrant ssh
 Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
 Welcome to your Vagrant-built virtual machine.
 last login: Fri Sep 14 06:23:18 2012 from 10.0.2.2
 vagrant@precise64:~$

5. Welcome to Salt!


The Hard Way
============

Do this from scratch.  Follow the installation instructions from the readme on
the `salty-vagrant github repo <https://github.com/saltstack/salty-vagrant>`_


We'll need the following to continue:
    * `Virtualbox <http://virtualbox.org>`_ (I'm using 4.2.10)
    * Ruby gem
    * `SaltStack <http://saltstack.org>`_
    * `salty vagrant <https://github.com/saltstack/salty-vagrant>`_
        * salty vagrant `installation instructions <https://github.com/saltstack/salty-vagrant#masterless-quick-start>`_ (We'll install it from vagrant)
    * A text editor of your choice. `Like this one <http://sublimetext.com>`_


Recap: this is all done on *Ubuntu Desktop 12.10*.  I have every bit of faith
that this will function on any other setup so long as you have Virtualbox and
Ruby with a little bit of Python magic.

SaltStack is OS agnostic (with some caveats on Windows), and will run on Linux,
FreeBSD, and Windows.

Let's add Salt to our Ubuntu repo list.  If you have a non-Debian based system
it's time to `look here instead
<http://docs.saltstack.com/topics/installation/index.html>`_. Otherwise:

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
    gpg: key 0E27C0A6: public key "Launchpad PPA for SaltStack" imported
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
the easy to read `instructions
<https://github.com/saltstack/salty-vagrant#masterless-quick-start>`_ would be
beneficial to everyone involved.

Here's the Copy/pasted from the link above:

#. Install Vagrant
#. Install Salty Vagrant (``vagrant plugin install vagrant-salt``)
#. Get the Ubuntu 12.04 base box: ``vagrant box add precise64 http://files.vagrantup.com/precise64.box``
#. Create/Update your ``Vagrantfile`` `Detailed in Configuration <https://github.com/saltstack/salty-vagrant#configuration>`_
#. Place your minion config in salt/minion
#. Run vagrant up and you should be good to go.

You can try starting now, but you'll run into errors about the missing SaltStack
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

      # We're saying "everyone" ('*') should run the 'vim' salt state we're
      # about to create.
      '*':
        - vim

      # Now we're stating all minions with the 'dev' role, run the following
      # salt state.  This state is called apache and it'll install the apache2
      # HTTP server
      'role : dev':
        - match: grain
        - apache

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
    	* Virtualbox (I'm using 4.2.10)
    	* ruby gem
    	* Salt Stack 
    	* salty-vagrant
    	* A text editor of your choice.
    
    Now repeat after me:
    Salt Stack is amazing!  It's simply Python & YAML & Jinja2 (oh my!).  All 
    magic within Salt Stack may be unlocked by reading the documentation.
    
    Installing All the Goodies
    ==========================
    
    Recap:  this is all done on *Ubuntu Desktop 12.10*.  I have every bit of faith 
    that this will function on any other setup so long as you have Virtualbox and 
    Ruby with a little bit of Python magic.
    
    .. code-block:: console
    
    sudo apt-add-repository ppa:saltstack/salt
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
    
    apt-get install gem
    
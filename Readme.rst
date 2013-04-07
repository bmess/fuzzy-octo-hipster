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
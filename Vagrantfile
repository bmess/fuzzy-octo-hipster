Vagrant.configure("2") do |config| 
  ## choose your base box
  config.vm.box = "precise64"
  
  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt/roots/", "/srv/"

  ## Use all of the defaults:
  config.vm.provision :salt do |salt|

    salt.run_highstate.true

  end
end

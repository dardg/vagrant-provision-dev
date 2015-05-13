# -*- mode: ruby -*-
# vi: set ft=ruby :

# Requires vagrant-reload plugin
# https://github.com/aidanns/vagrant-reload
# vagrant plugin install vagrant-reload

# Use vagrant-vbox-snapshot for incremental provisioning
# https://github.com/dergachev/vagrant-vbox-snapshot
# vagrant plugin install vagrant-vbox-snapshot

# vmware_fusion | virtualbox
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'


Vagrant.configure(2) do |config|

  config.vm.box = "boxcutter/ubuntu1404-desktop"
  
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.150"

  config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder "~/Documents/GitHub", "/home/vagrant/Documents/GitHub"

  config.vm.define "vagrant-dev" do |foohost|
  end

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.customize ["modifyvm", :id, "--name", "Vagrant Docker - Development"]
    v.customize ["modifyvm", :id, "--memory", 4096]
    v.customize ["modifyvm", :id, "--cpus", 4]
    v.customize ["modifyvm", :id, "--vram", "256"]
    v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
    v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  end

  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.vmx["name"] = "Vagrant Docker - Development"
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "2"
  end
  
  config.vm.provision :shell, :path => "provision.sh", privileged: false
  
  config.vm.provision :reload
  


end


# -*- mode: ruby -*-
# vi: set ft=ruby :

# Requires vagrant-reload plugin
# https://github.com/aidanns/vagrant-reload
# vagrant plugin install vagrant-reload

# Use vagrant-vbox-snapshot for incremental provisioning
# https://github.com/dergachev/vagrant-vbox-snapshot
# vagrant plugin install vagrant-vbox-snapshot

# vmware_fusion | virtualbox
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'vmware_fusion'

# Ensure that VMWare Tools recompiles kernel modules
# when we update the linux images
$fix_vmware_tools_script = <<SCRIPT
sed -i.bak 's/answer AUTO_KMODS_ENABLED_ANSWER no/answer AUTO_KMODS_ENABLED_ANSWER yes/g' /etc/vmware-tools/locations
sed -i.bak 's/answer AUTO_KMODS_ENABLED no/answer AUTO_KMODS_ENABLED yes/g' /etc/vmware-tools/locations
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.box = "boxcutter/ubuntu1404-desktop"
  
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  #config.vm.network "private_network", ip: "192.168.33.150"
  #config.vm.network "private_network", ip: "192.168.143.10"
  config.vm.network "forwarded_port", guest: 80, host: 10080
  config.vm.network "forwarded_port", guest: 8080, host: 18080

  #config.vm.synced_folder "./home", "/home"
  #config.vm.synced_folder "~/Documents/GitHub", "/home/vagrant/Documents/GitHub"
  config.vm.synced_folder "./data/", "/data"
  config.vm.synced_folder "/Volumes", "/volumes"

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
    #v.vmx["memsize"] = "4096"
    v.vmx["memsize"] = "3072"
    v.vmx["numvcpus"] = "4"
  end
  
  config.vm.provision :shell, inline: $fix_vmware_tools_script
  config.vm.provision :shell, :path => "provision_os.sh", privileged: false
  config.vm.provision :reload
  config.vm.provision :shell, :path => "provision_dev.sh", privileged: false
  config.vm.provision :reload
  config.vm.provision :shell, :path => "provision_os_always.sh", run: "always", privileged: false
  


end


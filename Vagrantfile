# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|

   config.vm.define "web", primary: true do |web|
      web.vm.box = "nrel/CentOS-6.7-x86_64"

      web.vm.synced_folder "./ansible", "/ansible", create: true
      web.vm.network :private_network, ip: "192.168.33.50"
      web.vm.network :forwarded_port, guest: 80, host: 8080
      web.vm.network :forwarded_port, guest: 443, host: 8081
      web.vm.hostname = "ansibleWeb"

      web.vm.provision "shell", path: "script/vagrant_provision.sh"
   end

end

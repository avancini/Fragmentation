# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "raring32"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.network "private_network", ip: "192.168.50.88"
  config.vm.network :forwarded_port, host: 7474, guest: 7474
  config.vm.network :forwarded_port, host: 9292, guest: 9292
end



# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box       = "fagbot"
  config.vm.box_url   = "http://files.vagrantup.com/precise32.box"

  config.vm.synced_folder ".", "/vagrant/"

  config.vm.provision :shell, :path => "bootstrap.sh"

  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  #config.ssh.forward_agent = true
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-17.10"

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.synced_folder '.', '/home/vagrant/workspace', type: "smb", mount_options: ["vers=3.02","mfsymlinks"]

end

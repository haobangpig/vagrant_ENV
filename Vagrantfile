# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos65-x86_64"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  config.vm.hostname = "myapp"
  config.vm.network :private_network, ip: (ENV["NCSA_VM_IP"] || "10.10.10.11")

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id,
                  "--memory", [ENV["NCSA_VM_MEM"].to_i, 1024].max,
                  "--cpus", [ENV["NCSA_VM_CPUS"].to_i, 1].max
                 ]
  end

  config.vm.provision :shell, path: "config/setup/server.sh"
  config.vm.provision :shell, inline: <<-CMD
    su -c 'bash -lx /vagrant/config/setup/ruby.sh' vagrant
    echo
    echo '### Next action ###'
    echo '$ cd ~/ && https://bitbucket.org/timedia/ncsa.git'
    echo '$ cd ncsa'
    echo '$ git config user.name 'Your name''
    echo '$ git config user.email 'your.address@example.com''
    echo
  CMD
end

# -*- mode: ruby -*-
# vi: set ft=ruby :
worker_cluster = {
  "ip-10-0-0-3.local-1.compute.worker" => { :ip => "10.0.0.3", :cpus => 1, :memory => 512 },
  "ip-10-0-0-4.local-1.compute.worker" => { :ip => "10.0.0.4", :cpus => 1, :memory => 512 }
}

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = "ip-10-0-0-2.local-1.compute.master"
    master.vm.network :private_network, ip: "10.0.0.2"
    master.vm.provision :shell, path: "bootstrap.sh"
    master.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 2048
    end
  end

 
  worker_cluster.each_with_index do |(hostname, info), index|
    config.vm.define "worker" do |worker|
      worker.vm.box = "centos/7"
      worker.vm.hostname = hostname
      worker.vm.network :private_network, ip: "#{info[:ip]}"
      worker.vm.provision :shell, path: "bootstrap.sh"
      worker.vm.provider "virtualbox" do |v|
        v.cpus = info[:cpus]
        v.memory = info[:memory]
      end
    end
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

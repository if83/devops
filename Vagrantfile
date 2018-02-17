# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "repo" do |repo|
    repo.vm.box = "centos/7"
    repo.vm.hostname = "repo"
    repo.vm.provision "shell",  path: "repo.sh"
    repo.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "RepoVM"
    end
    # web.vm.hostname = 'web'
    repo.vm.network :private_network, ip: "192.168.56.111"
    #repo.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
    # web.ssh.private_key_path = "/home/savr/.vagrant.d/insecure_private_key"
    # web.ssh.forward_agent = true
  end

  config.vm.define "test" do |t|
    t.vm.box = "centos/7"
    t.vm.hostname = "test"
    t.vm.provision "shell",  path: "test.sh"
    t.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "testVM"
    end
    t.vm.network "private_network", ip: "192.168.56.101"
    # db.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"
    # db.ssh.private_key_path = "/home/savr/.vagrant.d/insecure_private_key"
    # db.ssh.forward_agent = true

  end
  config.vm.provision "shell",  path: "start.sh"


end
